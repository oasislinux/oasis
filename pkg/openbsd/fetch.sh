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

sh "$basedir/scripts/extract.sh" "$distdir/src.tar.gz" -s ',^,src/,' \
	'bin/pax/*' \
	'include/*' \
	'lib/libc/*' \
	'lib/libcrypto/arc4random/*' \
	'lib/libutil/*' \
	'usr.bin/diff/*' \
	'usr.bin/doas/*' \
	'usr.bin/fmt/*' \
	'usr.bin/m4/*' \
	'usr.bin/nc/*' \
	'usr.bin/patch/*' \
	'usr.bin/rsync/*' \
	'usr.bin/yacc/*' \
	'usr.sbin/acme-client/*'
sh "$basedir/scripts/extract.sh" "$distdir/sys.tar.gz" -s ',^,src/,' 'sys/sys/*'

git apply -v --whitespace=nowarn --directory "$dir/src" patch/*.patch
