file=$1
shift

case $file in
*.tar.gz|*.tgz) tool=gzip  ;;
*.tar.bz2)      tool=bzip2 ;;
*.tar.xz)       tool=xz    ;;
*) exit 0
esac

"$tool" -d -c "$file" | "$PAX" -r "$@"
