set -e

if [ "$#" -lt 3 ] ; then
	printf 'usage: %s var out command...\n' "$0" >&2
	exit 2
fi

var=$1
out=$2
shift 2
if "$@" 2>"$out.log" ; then
	echo "#define $var 1"
fi >"$out"
