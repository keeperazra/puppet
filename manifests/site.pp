node /^mw[12]\.alex\.local$/ {
	include httpd
	include mediawiki
}

node "proxy.alex.local" {
	include httpd
}
