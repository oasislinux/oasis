import configparser
import hashlib
import json
import os
import subprocess
from pathlib import Path, PurePosixPath

entries = []

for pkg in Path('.').glob('pkg/*'):
	if not pkg.is_dir():
		continue
	hash = hashlib.new('sha256')
	paths = []
	try:
		with open(pkg.joinpath('sha256'), 'rb') as f:
			for line in f:
				hash.update(line)
				name = line.decode('utf-8').split()[1]
				paths.append(str(Path('dist').joinpath(name)))
	except FileNotFoundError:
		continue
	key = hash.hexdigest()
	entries.append({
		'key': f'{pkg.name}-{hash.hexdigest()}',
		'paths': paths,
	})

def gitrev(revs):
	cmd = ['git', 'rev-parse'] + revs
	result = subprocess.run(cmd, capture_output=True, text=True, check=True)
	return result.stdout.splitlines()
gitmodules = configparser.ConfigParser()
gitmodules.read('.gitmodules')
revs = []
pkgs = []
for name, section in gitmodules.items():
  if not name.startswith('submodule'):
    continue
  path = PurePosixPath(section['path'])
  if path.parts[0] != 'pkg' or path.parts[-1] != 'src':
    continue
  revs.append(f'HEAD:{path}')
  pkgs.append(PurePosixPath(*path.parts[1:-1]).as_posix())

entries.extend([{
	'key': f'{pkg}-{rev}',
	'paths': [f'.git/modules/pkg/{pkg}/src'],
} for pkg, rev in zip(pkgs, gitrev(revs))])

with open(os.getenv('GITHUB_OUTPUT'), 'w') as f:
	f.write('entries=')
	f.write(json.dumps(entries))
