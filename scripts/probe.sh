set -e

if [ "$#" -lt 2 ] ; then
	echo 'usage: probe.sh var command...' >&2
	exit 2
fi

var=$1
shift
if "$@" 2>/dev/null ; then
	echo "#define $var 1"
fi
