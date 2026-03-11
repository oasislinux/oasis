set -e

sh scripts/fetch-git.sh "$@"

. ./paths.sh
dir=$1
shift

cd "$distdir"

if ! sh "$basedir/scripts/checksum.sh" -c "$basedir/$dir/sha256" 2>/dev/null ; then
	curl -L -O -K "$basedir/$dir/url"
	sh "$basedir/scripts/checksum.sh" -c "$basedir/$dir/sha256"
fi

cd "$basedir/$dir"
rm -rf src/man

read -r _ archive <sha256
sh "$basedir/scripts/extract.sh" "$distdir/$archive" -s ',^\.,src/man,'
