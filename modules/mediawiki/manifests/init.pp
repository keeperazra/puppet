class mediawiki {

include mediawiki::packages

package { 'git':
	ensure => present,
}

exec { 'git_clone_mediawiki':
	cwd => '/tmp',
	command => '/usr/bin/git clone https://github.com/keeperazra/mw.git /var/www/html/mw',
	creates => '/var/www/html/mw/.git/config',
	user => 'deployer',
	group => 'deployer',
	require => Package['git'],
	notify => Exec['httpd-restart'],
}

if ( !defined( File['/var/www/html/mw'] ) ) {
	file { '/var/www/html/mw':
		ensure => 'directory',
		owner => 'deployer',
		group => 'deployer',
		before => Exec['git_clone_mediawiki'],
	}
}

exec { 'git_pull_mediawiki':
	cwd => '/var/www/html/mw',
	command => '/usr/bin/git pull --quiet',
	unless => '/usr/bin/git fetch && /usr/bin/git diff --quiet remotes/origin/HEAD',
	user => 'deployer',
	group => 'deployer',
	require => Exec['git_clone_mediawiki'],
	notify => Exec['httpd-restart'],
}

}
