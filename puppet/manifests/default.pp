class web {

  Exec {
    path => '/bin/:/sbin/:/usr/bin/:/usr/sbin/'
  }

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
    cwd     => '/tmp',
    command => '/usr/bin/wget --no-check-certificate https://github.com/rogerramossilva/devops/raw/master/express.zip',
    creates => '/tmp/express.zip',
    require => Package['wget'],
  }

  exec { 'unzip':
    cwd     => '/tmp',
    command => '/usr/bin/unzip /tmp/express.zip -d /srv/www/',
    creates => '/srv/www/express',
    unless  => 'test -d /srv/www/express/',
    require => Package['zip'],
  }

  service { 'apache2':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    restart    => true,
    require    => Package['apache2']
  }

  exec { 'a2enconf direxpress':
    path     => ['/usr/bin', '/usr/sbin'],
    provider => shell,
    require  => Package['apache2'],
    notify   => Service['apache2']
  }

  exec { 'a2ensite express':
    path     => ['/usr/bin', '/usr/sbin'],
    provider => shell,
    require  => Package['apache2'],
    notify   => Service['apache2']
  }

  exec { 'a2enmod vhost_alias':
    path     => ['/usr/bin', '/usr/sbin'],
    provider => shell,
    require  => Package['apache2'],
    notify   => Service['apache2']
  }

  exec { 'a2enmod php7.0':
    path     => ['/usr/bin', '/usr/sbin'],
    provider => shell,
    require  => Package['apache2'],
    notify   => Service['apache2']
  }

}

include web
