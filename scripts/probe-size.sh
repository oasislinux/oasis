set -e

if [ "$#" -lt 2 ] ; then
	echo 'usage: probe-size.sh var command...' >&2
	exit 2
fi

var=$1
shift
for size in 8 4 2 1 ; do
	if "$@" -D "$var=$size" 2>/dev/null ; then
		echo "#define $var $size"
		exit 0
	fi
done

printf "%s: could not determine %s\n" "$0" "$var" >&2
exit 1
