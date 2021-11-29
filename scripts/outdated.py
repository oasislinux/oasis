import collections
import json
import os
import subprocess
import sys
import urllib.request

names = {
	'awk': 'nawk',
	'lpeg': 'lua:lpeg',
	'sshfs': 'fusefs:sshfs',
	'st': 'st-term',
	'terminus-font': 'fonts:terminus',
	'the_silver_searcher': 'the-silver-searcher',
	'tz': 'tzdata',
	'wpa_supplicant': 'wpa-supplicant',
}
skip = set([
	'adobe-source-fonts',
	'cproc',
	'libutp',
	'mc',
	'openbsd',
	'qbe',
	'sbase',
	'sdhcp',
	'skeleton',
	'st',
	'swc',
	'ubase',
	'velox',
	'wld',
])

p = subprocess.Popen(['git', '-C', 'pkg', 'ls-tree', 'HEAD'], stdout=subprocess.PIPE)
for line in p.stdout:
	fields = line.decode().split()
	if fields[1] != 'tree' or fields[3] in skip:
		continue
	name = fields[3]
	try:
		with open('pkg/{}/ver'.format(name), 'r') as f:
			oldver = f.read().rsplit(maxsplit=1)[0]
	except FileNotFoundError:
		continue
	proj = names.get(name, name)
	with urllib.request.urlopen('https://repology.org/api/v1/project/{}'.format(proj)) as response:
		pkgs = json.loads(response.read())
	newest = collections.Counter()
	for pkg in pkgs:
		if pkg['status'] in ('newest', 'unique'):
			newest[pkg['version']] += 1
	if not newest:
		print('could not find newest version of {}'.format(proj), file=sys.stderr)
		continue
	newver = newest.most_common(1)[0][0]
	if oldver != newver:
		print('{:20} {:16} => {:16}'.format(name, oldver, newver))
if p.wait():
	raise CalledProcessError(p.retcode, p.args)
