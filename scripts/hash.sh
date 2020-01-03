set -e

if [ "$#" != 4 ] ; then
	echo 'usage: hash.sh repo mode name file' >&2
	exit 2
fi

repo=$1
mode=$2
name=$3
shift 3

case "$mode" in
12????)
	hash=$(printf %s "$1" | git -C "$repo" hash-object -w --stdin) ;;
10????)
	hash=$(git -C "$repo" hash-object -w --stdin <"$1") ;;
*)
	echo "invalid mode: $mode"
	exit 1
esac

printf '%s %s\t%s\n' "$mode" "$hash" "$name"
