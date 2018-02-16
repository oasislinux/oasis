set -e

var=$1
shift
if "$@" 2>/dev/null ; then
	echo "#define $var 1"
fi
