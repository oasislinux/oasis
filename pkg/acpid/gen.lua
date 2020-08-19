cflags{
	'-Wall', '-Wpedantic',
	'-Wno-overflow',  -- ioctl opcode conversion
	'-D _GNU_SOURCE',
	'-include $dir/config.h',
}

lib('libcommon.a', {'log.c', 'ud_socket.c'})

exe('acpid', {
	'acpid.c',
	'acpi_ids.c',
	'connection_list.c',
	'event.c',
	'input_layer.c',
	'inotify_handler.c',
	'libnetlink.c',
	'netlink.c',
	'proc.c',
	'sock.c',
	'libcommon.a',
})
file('bin/acpid', '755', '$outdir/acpid')
man{'acpid.8'}

exe('acpi_listen', {'acpi_listen.c', 'libcommon.a'})
file('bin/acpi_listen', '755', '$outdir/acpi_listen')
man{'acpi_listen.8'}

fetch 'git'
