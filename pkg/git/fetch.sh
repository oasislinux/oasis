set -e

sh scripts/fetch-git.sh "$@"

cd "$1"
shift

if [ -e src/man ] ; then
	rm -rf src/man
fi

if ! sh "$OLDPWD/scripts/checksum.sh" -c sha256 2>/dev/null ; then
	curl -L -O -K url
	sh "$OLDPWD/scripts/checksum.sh" -c sha256
fi

read -r _ archive <sha256
sh "$OLDPWD/scripts/extract.sh" "$archive" -s ',^\.,src/man,'
