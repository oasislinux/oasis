set -e

dir=$1
shift

cd "$dir"

if [ -e src ] ; then
        rm -rf src
fi

if ! sh "$OLDPWD/scripts/checksum.sh" -c sha256 2>/dev/null ; then
        curl -L -K url -O
        sh "$OLDPWD/scripts/checksum.sh" -c sha256
fi

read -r _ archive <sha256
sh "$OLDPWD/scripts/extract.sh" "$archive" -s ',^[^/]*,src,' \
	'linux-*/Makefile' \
	'linux-*/arch/*/include/uapi/' \
	'linux-*/arch/*/entry/syscalls/' \
	'linux-*/include/uapi/' \
	'linux-*/scripts/unifdef.c'

if [ -d patch ] ; then
	git apply -v --whitespace=nowarn --directory "$dir/src" patch/*
fi
