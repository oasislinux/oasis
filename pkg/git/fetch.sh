: "${SHA256SUM:=sha256sum}"
: "${PAXREAD:=pax -r}"

set -e

sh scripts/fetch-git.sh "$@"

cd "$1"
shift

if [ -e src/man ] ; then
	rm -rf src/man
fi

if ! $SHA256SUM -c sha256 2>/dev/null ; then
	curl -L -O -K url
	$SHA256SUM -c sha256
fi

read -r _ archive <sha256
gzip -d -c "$archive" | $PAXREAD -s ',^\.,src/man,'
