# Public: Install and configure dnsmasq from homebrew.
#
# Examples
#
#   include dnsmasq
class dnsmasq {
  require homebrew
  require dnsmasq::config

  file { "${dnsmasq::config::configfile}":
    notify  => Service['dev.dnsmasq'],
    content  => template('dnsmasq/dnsmasq.conf.erb')
  }

  file { "${dnsmasq::config::configdir}":
    ensure  => directory,
    notify  => Service['dev.dnsmasq'],
  }

  file { '/etc/resolver':
    ensure => directory,
    group  => 'wheel',
    owner  => 'root'
  }

  file { '/Library/LaunchDaemons/dev.dnsmasq.plist':
    content => template('dnsmasq/dev.dnsmasq.plist.erb'),
    group   => 'wheel',
    notify  => Service['dev.dnsmasq'],
    owner   => 'root'
  }

  package { 'dnsmasq':
    ensure => 'latest',
    notify => Service['dev.dnsmasq']
  }

  service { 'dev.dnsmasq':
    ensure  => running,
    require => Package['dnsmasq']
  }

  dnsmasq::address { 'dev': }
}
