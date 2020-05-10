if command -v sha256sum >/dev/null; then
	exec sha256sum "$@"
elif command -v sha256 >/dev/null; then
	exec sha256 "$@"
elif command -v shasum >/dev/null; then
	exec shasum -a 256 "$@"
else
	printf '%s: sha256sum, sha256, or shasum required\n' "$0" >&2
	exit 1
fi
