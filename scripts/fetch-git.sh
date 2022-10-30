set -e

if [ "$#" != 1 ] ; then
	echo 'usage: fetch-git.sh dir' >&2
	exit 2
fi

cd "$1"

git submodule update --init --checkout src
if [ -d patch ] ; then
	git -C src am --keep-non-patch --whitespace=nowarn "$PWD"/patch/*.patch
fi
