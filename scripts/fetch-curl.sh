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

if ! sha256sum -c sha256 2>/dev/null ; then
	curl -L -K url -O
	sha256sum -c sha256
fi

while read -r checksum archive ; do
	case $archive in
	*.tar.gz|*.tgz)
		tool=zcat ;;
	*.tar.bz2)
		tool=bzcat ;;
	*.tar.xz)
		tool=xzcat ;;
	*)
		tool=
	esac
	if [ -n "$tool" ] ; then
		"$tool" "$archive" | pax -r -s '/^\.\|[^\/]*/src/' '*/*'
	fi
done <sha256

if [ -d patch ] ; then
	git apply -v --whitespace=nowarn --directory "$dir/src" patch/*
fi
