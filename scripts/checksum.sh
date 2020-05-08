if command -v sha256sum >/dev/null; then
	exec sha256sum "$@"
elif command -v shasum >/dev/null; then
	exec shasum -a 256 "$@"
else
	printf '%s: sha256sum or shasum required\n' "$0" >&2
	exit 1
fi
