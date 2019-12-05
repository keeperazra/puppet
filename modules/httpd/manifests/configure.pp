class httpd::configure {

file { '/etc/httpd/conf.d/welcome.conf':
	ensure => absent,
}

$httpd_conf = lookup('httpd_conf')
$source = "puppet:///modules/httpd/${httpd_conf}"

file { '/etc/httpd/conf/httpd.conf':
	mode => '0644',
	owner => 'root',
	group => 'root',
	source => $source,
	notify => Exec['httpd-restart'],
}

}
