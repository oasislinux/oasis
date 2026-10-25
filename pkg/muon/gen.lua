cflags{
	'-std=c99',
	'-Wall', '-Wpedantic', '-Wno-missing-braces',
	'-D MUON_PLATFORM_posix',
	'-D MUON_ENDIAN=0',
	'-D MUON_STATIC',
	'-D MUON_BOOTSTRAPPED',
	'-I $outdir',
	'-I $srcdir/include',
}

sub('tools.ninja', function()
	toolchain(config.host)
	cflags{'-I $srcdir/include'}
	exe('embedder', {'tools/embedder.c'})
end)

rule('embedder', '$outdir/embedder $args >$out')

local embed = {
	'commands/clang_format.meson',
	'commands/copyfile.meson',
	'commands/coverage.meson',
	'commands/delete_suffix.meson',
	'commands/i18n/gettext.meson',
	'commands/i18n/itstool.meson',
	'commands/i18n/msgfmthelper.meson',
	'commands/vcs_tagger.meson',
	'html/docs.html',
	'html/test_out.html',
	'lib/cmake_prelude.meson',
	'modules/gnome.meson',
	'modules/i18n.meson',
	'modules/wayland.meson',
	'modules/windows.meson',
	'options/global.meson',
	'options/per_project.meson',
	'python/python_info.py',
	'runtime/dependencies.meson',
	'runtime/toolchains.meson',
}

local args = {}
for _, file in ipairs(embed) do
	table.insert(args, '$srcdir/src/script/'..file)
	table.insert(args, file)
end

build('embedder', '$outdir/embedded_files.h', {expand{'$srcdir/src/script', embed}, '|', '$outdir/embedder'}, {args=args})

build('sed', '$outdir/version.c', '$srcdir/src/version.c.in', {
	expr={
		'-e s,@version@,0.6.0,',
		'-e s,@vcs_tag@,,',
		'-e s,@meson_compat@,1.7,',
	},
})

pkg.deps = {
	'$outdir/embedded_files.h',
}

exe('muon', [[
	src/(
		arena.c args.c cmd_install.c cmd_subprojects.c 
		cmd_test.c coerce.c embedded.c
		error.c guess.c install.c log.c
		machine_file.c machines.c main.c
		memmem.c meson_opts.c options.c
		opts.c rpmvercmp.c sha_256.c toolchains.c
		vsenv.c wrap.c ui_null.c
		backend/(
			backend.c common_args.c introspect.c ninja.c output.c xcode.c
			ninja/(
				alias_target.c coverage.c build_target.c
				clang_format.c custom_target.c rules.c
			)
		)
		datastructures/(
			arr.c bucket_arr.c hash.c seg_list.c stack.c
		)
		formats/(
			ansi.c editorconfig.c ini.c ini_cfg.c json.c
			lines.c tap.c xml.c
		)
		functions/(
			array.c bool.c both_libs.c
			build_target.c compiler.c
			configuration_data.c custom_target.c
			dependency.c dict.c disabler.c
			environment.c external_program.c
			feature_opt.c file.c generator.c include_directory.c
			kernel.c modules.c machine.c meson.c
			number.c run_result.c
			source_configuration.c source_set.c
			string.c subproject.c
			kernel/(
				build_target.c configure_file.c
				custom_target.c dependency.c
				install.c options.c subproject.c
			)
			modules/(
				curl.c fs.c getopt.c keyval.c pkgconfig.c
				python.c sourceset.c time.c subprojects.c
				toolchain.c util.c json.c
			)
		)
		lang/(
			analyze.c compiler.c dap.c docs.c eval.c
			fmt.c func_lookup.c lexer.c lsp.c
			object.c object_iterators.c parser.c
			serial.c server.c string.c typecheck.c
			vm.c workspace.c
		)
		platform/(
			assert.c filesystem.c os.c mem.c
			path.c run_cmd.c uname.c
			posix/(
				filesystem.c init.c log.c
				os.c path.c rpath_fixer.c
				run_cmd.c term.c timer.c
				uname.c socket.c
			)
			null/(backtrace.c)
		)
		external/(
			libarchive_null.c libcurl_null.c
			samurai_null.c readline_builtin.c
			pkgconfig.c pkgconfig_exec.c
		)
	)
	$outdir/version.c
]])

file('bin/muon', '755', '$outdir/muon')

fetch 'git'
