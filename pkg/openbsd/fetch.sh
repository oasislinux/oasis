set -e

dir=$1
shift

cd "$dir"

if [ -e src ] ; then
        rm -rf src
fi

if ! sh "$OLDPWD/scripts/checksum.sh" -c sha256 2>/dev/null ; then
        curl -L -K url -O
        sh "$OLDPWD/scripts/checksum.sh" -c sha256
fi

sh "$OLDPWD/scripts/extract.sh" src.tar.gz -s ',^,src/,' \
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
sh "$OLDPWD/scripts/extract.sh" sys.tar.gz -s ',^,src/,' 'sys/sys/*'

git apply -v --whitespace=nowarn --directory "$dir/src" patch/*
