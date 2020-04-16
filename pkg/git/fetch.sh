: ${SHA256SUM:=sha256sum}
: ${PAXREAD:=pax -r}

set -e

(. ./scripts/fetch-git.sh "$@")

cd "$1"
shift

if [ -e src/man ] ; then
	rm -rf src/man
fi

if ! $SHA256SUM -c sha256 2>/dev/null ; then
	curl -L -O -K url
	$SHA256SUM -c sha256
fi

read -r checksum archive <sha256
xz -d -c "$archive" | $PAXREAD -s ',^\.,src/man,'
