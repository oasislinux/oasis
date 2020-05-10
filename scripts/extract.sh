file=$1
shift

case $file in
*.tar.gz|*.tgz) tool=gzip  ;;
*.tar.bz2)      tool=bzip2 ;;
*.tar.xz)       tool=xz    ;;
*) exit 0
esac

if command -v bsdtar >/dev/null; then
	exec bsdtar -xf "$file" "$@"
elif command -v pax >/dev/null; then
	"$tool" -d -c "$file" | pax -r "$@"
else
	printf '%s: bsdtar or pax is required' "$0" >&2
	exit 1
fi
