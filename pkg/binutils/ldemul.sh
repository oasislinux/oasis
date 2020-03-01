printf 'extern ld_emulation_xfer_type ld_%s_emulation;\n' "$@"
printf '#define EMULATION_LIST '
printf '&ld_%s_emulation, ' "$@"
printf '0\n'
