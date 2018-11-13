set -e

(. ./scripts/fetch-git.sh "$@")

cd "$1"
shift

if [ -e src/man ] ; then
	rm -rf src/man
fi

if ! sha256sum -c sha256 2>/dev/null ; then
	curl -L -O -K url
	sha256sum -c sha256
fi

read -r checksum archive <sha256
xzcat "$archive" | ${PAXREAD:-pax -r} -s ',^\.,src/man,'
