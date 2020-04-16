# scripts/headers_install.sh
s/([[:space:](])(__user|__force|__iomem)[[:space:]]/\1/g
s/__attribute_const__([[:space:]]|$)/\1/g
s@^#include <linux/compiler(_types)?.h>@@
s/(^|[^a-zA-Z0-9])__packed([^a-zA-Z0-9_]|$)/\1__attribute__((packed))\2/g
s/(^|[[:space:](])(inline|asm|volatile)([[:space:](]|$)/\1__\2__\3/g
s@#(ifndef|define|endif[[:space:]]*/[*])[[:space:]]*_UAPI@#\1 @
