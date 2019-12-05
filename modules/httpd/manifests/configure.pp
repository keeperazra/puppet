class httpd::configure (
	Optional[String] $httpd_conf = 'httpd.conf'
) {

file { '/etc/httpd/conf.d/welcome.conf':
	ensure => absent,
}

$source = "puppet:///modules/httpd/${httpd_conf}"

file { '/etc/httpd/conf/httpd.conf':
	mode => '0644',
	owner => 'root',
	group => 'root',
	source => $source,
	notify => Exec['httpd-restart'],
}

}
