phony('cacert.pem', '$dir/fetch')
file('share/cacert/cert.pem', '644', '$dir/cacert.pem')

fetch 'curl'
