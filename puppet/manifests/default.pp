class web {

  exec { 'apt update':
    command => 'apt-get update',
    path    => ['/usr/bin', '/usr/sbin']
  }

  package {
    [
      'php7.0',
      'php-pear',
      'php7.0-curl',
      'php7.0-gd',
      'php7.0-intl',
      'php7.0-xmlrpc',
      'php7.0-mysql',
      'apache2',
      'python-mysqldb',
      'wget',
      'curl',
      'vim',
      'zip',
    ]:
    ensure => installed,
  }

  file { '/etc/apache2/conf-available/direxpress.conf':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    replace => true,
    content => template('/vagrant/puppet/files/direxpress.conf'),
    require => Package['apache2'],
  }

  file { '/etc/apache2/sites-available/express.conf':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    replace => true,
    content => template('/vagrant/puppet/files/express.conf'),
    require => Package['apache2'],
  }

  file { '/etc/hosts':
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    replace => true,
    content => template('/vagrant/puppet/files/hosts'),
  }

  file { '/srv/www':
    ensure => directory,
    owner  => root,
    group  => www-data,
    mode   => '2750',
  }

  exec { 'wget-express.zip':
    cwd => '/tmp',
    command => '/usr/bin/wget --no-check-certificate https://github.com/rogerramossilva/devops/raw/master/express.zip',
    creates => '/tmp/express.zip',
    require => Package['wget'],
  }

}

include web
