set -e

. ./paths.sh
dir=$1
shift

cd "$distdir"

if ! sh "$basedir/scripts/checksum.sh" -c "$basedir/$dir/sha256" 2>/dev/null ; then
        curl -L -K "$basedir/$dir/url" -O
        sh "$basedir/scripts/checksum.sh" -c "$basedir/$dir/sha256"
fi

cd "$basedir/$dir"
rm -rf src

read -r _ archive <sha256
sh "$basedir/scripts/extract.sh" "$distdir/$archive" -s ',^[^/]*,src,' \
	'linux-*/Makefile' \
	'linux-*/arch/*/include/uapi/' \
	'linux-*/arch/*/entry/syscalls/' \
	'linux-*/include/uapi/' \
	'linux-*/scripts/syscall.tbl' \
	'linux-*/scripts/unifdef.c'

if [ -d patch ] ; then
	git apply -v --whitespace=nowarn --directory "$dir/src" patch/*.patch
fi
