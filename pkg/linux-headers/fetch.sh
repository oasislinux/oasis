: ${SHA256SUM:=sha256sum}
: ${PAXREAD:=pax -r}

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

read -r _ archive <sha256

xz -d -c "$archive" | $PAXREAD -s ',^[^/]*,src,' \
	'linux-*/Makefile' \
	'linux-*/arch/*/include/uapi' \
	'linux-*/arch/*/syscalls' \
	'linux-*/include/uapi' \
	'linux-*/scripts/unifdef.c'

if [ -d patch ] ; then
	git apply -v --whitespace=nowarn --directory "$dir/src" patch/*
fi
