# Internal: Configure dnsmasq.
#
# Examples
#
#   include dnsmasq::config
class dnsmasq::config {
  include homebrew::config

  $configroot = "${homebrew::config::installdir}/etc"
  $configfile = "${configroot}/dnsmasq.conf"
  $configdir  = "${configroot}/dnsmasq.d"

  anchor { [
    $configroot,
    $configfile,
    $configdir,
  ]: }
}
