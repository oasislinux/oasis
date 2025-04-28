s|@SHELL_PATH@|/bin/sh|
s|@DIFF@|diff|
s|@LOCALEDIR@|/share/locale|g
s|@USE_GETTEXT_SCHEME@||g
/^\# @BROKEN_PATH_FIX@$/d
s|@GITWEBDIR@|/share/gitweb|g
s|@PERL_PATH@|/bin/perl|g
s|@PAGER_ENV@|LESS=FRX LV=-c|g
