set -e

if [ "$#" -lt 3 ] ; then
	printf 'usage: %s var out command...\n' "$0" >&2
	exit 2
fi

var=$1
out=$2
shift 2
for size in 8 4 2 1 ; do
	echo "==> trying $var=$size..." >&2
	if "$@" -D "$var=$size" ; then
		echo '==> success' >&2
		echo "#define $var $size" >"$out"
		exit 0
	fi
done 2>"$out.log"

cat "$out.log"
printf "%s: could not determine %s\n" "$0" "$var" >&2
exit 1
