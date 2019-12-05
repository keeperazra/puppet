class httpd::service {

package { 'httpd':
	ensure => present,
}

service { 'httpd':
	ensure => running,
	enable => true,
	require => Package['httpd'],
}

exec { 'httpd-restart':
	command => '/usr/bin/systemctl restart httpd',
	require => Service['httpd'],
	refreshonly => true,
}

}
