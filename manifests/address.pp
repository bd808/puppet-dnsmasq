define dnsmasq::address(
  $ipaddr = '127.0.0.1',
  $ensure = 'present',
  $priority = 10,
){
  include dnsmasq::config

  file { "${dnsmasq::config::configdir}/${priority}-${name}":
    ensure => $ensure,
    content => "address=/${name}/${ipaddr}",
    notify => Service['dnsmasq'],
  }

  file { '/etc/resolver':
    ensure => directory,
    group  => 'wheel',
    owner  => 'root'
  }

  file { "/etc/resolver/${name}":
    content => 'nameserver 127.0.0.1',
    group   => 'wheel',
    owner   => 'root',
    require => File['/etc/resolver'],
    notify  => Service['dnsmasq'],
  }
}
