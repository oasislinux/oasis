set -e

repo=$1
branch=$2
tag=$3
out=$4

if git -C "$repo" show-ref -q --verify "refs/heads/$branch" ; then
	set -- -p "$branch"
else
	set --
fi

commit=$(git -C "$repo" commit-tree -m "oasis built by $(id -un)" "$@" "$tag")
git -C "$repo" update-ref "refs/heads/$branch" "$commit"
echo "$commit" >"$out.tmp" && mv "$out.tmp" "$out"
