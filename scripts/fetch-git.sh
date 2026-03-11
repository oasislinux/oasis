set -e

if [ "$#" != 1 ] ; then
	echo 'usage: fetch-git.sh dir' >&2
	exit 2
fi

. ./paths.sh
cd "$basedir/$1"

git submodule update --init --checkout src
if [ -d patch ] ; then
	cd src
	git am --keep-non-patch --whitespace=nowarn ../patch/*.patch
fi
