: "${SHA256SUM:=sha256sum}"
: "${PAXREAD:=pax -r}"

set -e

dir=$1
shift

cd "$dir"

if [ -e src ] ; then
        rm -rf src
fi

if ! $SHA256SUM -c sha256 2>/dev/null ; then
        curl -L -K url -O
        $SHA256SUM -c sha256
fi

gzip -d -c src.tar.gz | $PAXREAD -s ',^,src/,' \
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
gzip -d -c sys.tar.gz | $PAXREAD -s ',^,src/,' 'sys/sys/*'

git apply -v --whitespace=nowarn --directory "$dir/src" patch/*
