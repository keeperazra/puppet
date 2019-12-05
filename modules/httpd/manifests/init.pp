class httpd {

include httpd::service
include httpd::configure

# Ensure firewall rules have been updated
exec { 'firewall-enable':
	command => '/usr/bin/firewall-cmd --add-service http --permanent',
	unless => '/usr/bin/firewall-cmd --list-services | /bin/grep -w http',
	notify => Exec['firewall-reload'],
}

exec { 'firewall-reload':
	command => '/usr/bin/firewall-cmd --reload',
	require => Exec['firewall-enable'],
	refreshonly => true
}

# Allow httpd to connect to mysql
exec { 'selinux-fix':
	command => '/usr/sbin/setsebool -P httpd_can_network_connect 1',
	unless => '/usr/sbin/getsebool httpd_can_network_connect | /bin/grep -w on',
}

}
