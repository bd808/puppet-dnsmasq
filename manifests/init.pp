# Public: Install and configure dnsmasq from homebrew.
#
# Examples
#
#   include dnsmasq
class dnsmasq {
  require homebrew
  require dnsmasq::config
  require dnsmasq::address

  file { "${dnsmasq::config::configfile}":
    notify  => Service['dnsmasq'],
    source  => template('dnsmasq/dnsmasq.conf.erb')
  }

  file { "${dnsmasq::config::configdir}":
    ensure  => directory,
    notify  => Service['dnsmasq'],
    require => File[$dnsmasq::config::configroot],
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
