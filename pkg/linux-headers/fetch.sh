set -e

dir=$1
shift

cd "$dir"

if [ -e src ] ; then
        rm -rf src
fi

if ! sha256sum -c sha256 2>/dev/null ; then
        curl -L -K url -O
        sha256sum -c sha256
fi

read -r _ archive <sha256

xzcat "$archive" | ${PAXREAD:-pax -r} -s ',^[^/]*,src,' \
	'linux-*/Makefile' \
	'linux-*/arch/*/include/uapi' \
	'linux-*/arch/*/syscalls' \
	'linux-*/include/uapi' \
	'linux-*/scripts/unifdef.c'
