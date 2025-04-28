set -e

if [ "$#" != 1 ] ; then
	echo 'usage: fetch-curl.sh dir' >&2
	exit 2
fi

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

while read -r _ archive ; do
	sh "$OLDPWD/scripts/extract.sh" "$archive" -s ',^[^/]*,src,'
done <sha256

if [ -d patch ] ; then
	git apply -v --whitespace=nowarn --directory "$dir/src" patch/*.patch
fi
