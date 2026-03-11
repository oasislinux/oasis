set -e

if [ "$#" != 1 ] ; then
	echo 'usage: fetch-curl.sh dir' >&2
	exit 2
fi

. ./paths.sh
dir=$1
shift

cd "$distdir"

if ! sh "$basedir/scripts/checksum.sh" -c "$basedir/$dir/sha256" 2>/dev/null ; then
	curl -L -K "$basedir/$dir/url" -O
	sh "$basedir/scripts/checksum.sh" -c "$basedir/$dir/sha256"
fi

cd "$basedir/$dir"

if [ -e src ] ; then
	rm -rf src
fi

while read -r _ archive ; do
	sh "$basedir/scripts/extract.sh" "$distdir/$archive" -s ',^[^/]*,src,'
done <sha256

if [ -d patch ] ; then
	git apply -v --whitespace=nowarn --directory "$dir/src" patch/*.patch
fi
