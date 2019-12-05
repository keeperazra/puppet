class httpd::configure {

file { '/etc/httpd/conf.d/welcome.conf':
	ensure => absent,
}

file { '/etc/httpd/conf/httpd.conf':
	mode => '0644',
	owner => 'root',
	group => 'root',
	source => 'puppet:///modules/httpd/httpd.conf',
}

}
