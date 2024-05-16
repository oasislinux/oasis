set -e

if [ "$#" != 4 ] ; then
	echo 'usage: tree.sh repo tag index out' >&2
	exit 2
fi

repo=$1
tag=$2
index=$3
out=$4

export GIT_INDEX_FILE="$PWD/$out.index"
git -C "$repo" read-tree --empty
git -C "$repo" update-index --index-info <"$index"
tree=$(git -C "$repo" write-tree)
git -C "$repo" update-ref "refs/tags/$tag" "$tree"

printf '%s\n' "$tree" >"$out.tmp"
if cmp -s "$out" "$out.tmp" ; then
	rm "$out.tmp"
else
	mv "$out.tmp" "$out"
fi
