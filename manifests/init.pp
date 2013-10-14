# Public: Install and configure dnsmasq from homebrew.
#
# Examples
#
#   include dnsmasq
class dnsmasq {
  require homebrew
  require dnsmasq::config

  file { "${dnsmasq::config::configfile}":
    notify  => Service['dnsmasq'],
    content  => template('dnsmasq/dnsmasq.conf.erb')
  }

  file { "${dnsmasq::config::configdir}":
    ensure  => directory,
    notify  => Service['dnsmasq'],
  }

  file { '/etc/resolver':
    ensure => directory,
    group  => 'wheel',
    owner  => 'root'
  }

  package { 'dnsmasq':
    ensure => 'latest',
    notify => Service['dnsmasq']
  }

  service { 'dnsmasq':
    ensure  => running,
    require => Package['dnsmasq']
  }

  dnsmasq::address { 'dev': }
}
