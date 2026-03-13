-- TODO: this feels a bit hacky
local cacert = basedir..'/'..config.distdir..'/cacert.pem'
build('phony', cacert, '$dir/fetch')
file('share/cacert/cert.pem', '644', cacert)

fetch 'curl'
