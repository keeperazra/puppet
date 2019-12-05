class mediawiki::packages {

package { ['epel-release', 'yum-utils']:
	ensure => present,
}

package { 'remi':
	name => 'http://rpms.remirepo.net/enterprise/remi-release-7.rpm',
	ensure => present,
	require => Package['epel-release'],
}

exec { 'enable-remi':
	command => '/usr/bin/yum-config-manager --enable remi-php73',
	require => [ Package['yum-utils'], Package['remi'] ],
	unless => '/bin/grep enabled=1 /etc/yum.repos.d/remi-php73.repo',
}

$pkgs = [
	'php',
	'php-apcu',
	'php-intl',
	'php-mbstring',
	'php-xml',
	'php-mysql',
]

package { $pkgs:
	ensure => latest,
	require => Exec['enable-remi'],
}

}
