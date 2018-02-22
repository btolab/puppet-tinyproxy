# == Class tinyproxy
#
# This module manages tinyproxy
#
# === Parameters
#
# [*ensure*]
#   Optional. If service should be managed. Valid values: present, absent
#
# [*package*]
#   Optional. Name of package to install
#
# [*autoupgrade*]
#   Optional. Boolean or version to pin
#
# [*service*]
#   Optional. Name of service to manage
#
# [*user*]
#   Optional. System user to run the service
#
# [*group*]
#    Optional. System group to run the service
#
# [*port*]
#   Optional. Port to listen to
#
# [*listen*]
#   Optional. Interface to listen to
#
# [*bind*]
#   Optional. Interface to bind outgoing connections
#
# [*bindsame*]
#   Optional. Boolean if same interface should be used for outgoing as incoming
#
# [*connection_timeout*]
#   Optional. Proxy timeout in seconds
#
# [*allow*]
#   Optional. Array of clients allowed access
#
# [*errorfiles*]
#   Optional. Hash of Statuscode => /Path/To/File
#   For example { 404 => "/path/to/my/404.html", 500 => "/path/to/my/500.html" }
#
# [*defaulterrorfile*]
#   Optional. Path to default error file
#
# [*debugerrorfile*]
#   Optional. Path to default error file
#
# [*debugmode*]
#   Optional. Boolean. Use debugerrorfile instead of defaulterrorfile for debugging.
#
# [*stathost*]
#   Optional. Host name or ip address of stat host
#
# [*statfile*]
#   Optional. HTML file that gets sent when a request is made for the stathost
#
# [*logfile*]
#   Optional. Path to log file
#
# [*syslog*]
#   Optional. Boolean if to use syslog. Default to false.
#
# [*log_level*]
#   Optional. One of Critical, Error, Warning, Notice, Connect, Info
#
# [*pidfile*]
#   Optional. Path to pid file
#
# [*maxclients*]
#   Optional. Max amount of concurrent clients
#
# [*minspareservers*]
#   Optional. Minimum amount of server processes spawned
#
# [*maxspareservers*]
#   Optional. Maximum amount of server processes spawned
#
# [*startservers*]
#   Optional. Amount of server processes spawned on startup
#
# [*maxrequestsperchild*]
#   Optional. Number of connections to handle until the thread is killed
#
# [*xtinyproxy*]
#   Optional. Tell Tinyproxy to include the X-Tinyproxy header, which
#   contains the client's IP address.
#
# [*viaproxyname*]
#   Optional. Host name to set in the Via header
#
# [*disableviaheader*]
#   Optional. Boolean to disable Via header
#
# [*filter*]
#   Optional. Path to filter file
#
# [*filtercontent*]
#   Optional. Array. Populate the filter file 
#   with the contents of this array, one entry per line.
#
# [*filterurls*]
#   Optional. Boolean to filter on URL rather than domain
#
# [*filterextended*]
#   Optional. Boolean to use POSIX extended regex rather than basic
#
# [*filtercasesensitive*]
#   Optional. Boolean to use case sensitive regexps
#
# [*filterdefaultdeny*]
#   Optional. Boolean to set default filtering policy
#
# [*anonymous*]
#   Optional. Array of headers allowed through anonymous proxying
#
# [*connectport*]
#   Optional. Array of allowed ports to use CONNECT
#
# [*reverseonly*]
#   Optional. Boolean if reverse proxy only should be enabled
#
# [*reversemagic*]
#   Optional. Boolean if cookie tracking of reverse proxy mappings should be used
#
# [*config_source*]
#   Optional. Path to puppet source file to use as tinyproxy configuration
#
# [*upstreams*]
#   Optional. Hash to create resources tinyproxy::upstream
#
# [*noupstreams*]
#   Optional. Hash to create resources tinyproxy::noupstream
#
# [*reversepaths*]
#   Optional. Hash to create resources tinyproxy::reversepath
#
# === Sample Usage
#
# class { 'tinyproxy':
#   ensure  => present,
#   port    => 8080,
# }
#
class tinyproxy (
  $ensure              = 'present',
  $package             = $tinyproxy::params::package,
  $autoupgrade         = $tinyproxy::params::autoupgrade,
  $service             = $tinyproxy::params::service,
  $user                = $tinyproxy::params::user,
  $group               = $tinyproxy::params::group,
  $port                = $tinyproxy::params::port,
  $listen              = $tinyproxy::params::listen,
  $bind                = $tinyproxy::params::bind,
  $bindsame            = $tinyproxy::params::bindsame,
  $connection_timeout  = $tinyproxy::params::connection_timeout,
  $allow               = $tinyproxy::params::allow,
  $errorfiles          = $tinyproxy::params::errorfiles,
  $defaulterrorfile    = $tinyproxy::params::defaulterrorfile,
  $debugerrorfile      = $tinyproxy::params::debugerrorfile,
  $debugmode           = $tinyproxy::params::debugmode,
  $stathost            = $tinyproxy::params::stathost,
  $statfile            = $tinyproxy::params::statfile,
  $logfile             = $tinyproxy::params::logfile,
  $syslog              = $tinyproxy::params::syslog,
  $log_level           = $tinyproxy::params::log_level,
  $pidfile             = $tinyproxy::params::pidfile,
  $maxclients          = $tinyproxy::params::maxclients,
  $minspareservers     = $tinyproxy::params::minspareservers,
  $maxspareservers     = $tinyproxy::params::maxspareservers,
  $startservers        = $tinyproxy::params::startservers,
  $maxrequestsperchild = $tinyproxy::params::maxrequestsperchild,
  $xtinyproxy          = $tinyproxy::params::xtinyproxy,
  $viaproxyname        = $tinyproxy::params::viaproxyname,
  $disableviaheader    = $tinyproxy::params::disableviaheader,
  $filter              = $tinyproxy::params::filter,
  $filtercontent       = $tinyproxy::params::filtercontent,
  $filterurls          = $tinyproxy::params::filterurls,
  $filterextended      = $tinyproxy::params::filterextended,
  $filtercasesensitive = $tinyproxy::params::filtercasesensitive,
  $filterdefaultdeny   = $tinyproxy::params::filterdefaultdeny,
  $anonymous           = $tinyproxy::params::anonymous,
  $connectport         = $tinyproxy::params::connectport,
  $reverseonly         = $tinyproxy::params::reverseonly,
  $reversemagic        = $tinyproxy::params::reversemagic,
  $config_source       = undef,
  $upstreams           = {},
  $noupstreams         = {},
  $reversepaths        = {},
) inherits tinyproxy::params {

  if $debugmode {
    $defaulterrorfile_real = $debugerrorfile
  } else {
    $defaulterrorfile_real = $defaulterrorfile
  }

  $template = $config_source ? {
    undef   => template('tinyproxy/tinyproxy.conf.erb'),
    default => undef
  }
  $ensure_file = $ensure ? {
    present => 'file',
    default => $ensure,
  }
  case $ensure {
    'present': {
      $version = $autoupgrade ? {
        /^[0-9]/ => $autoupgrade,
        true     => 'latest',
        default  => 'present'
      }
      service { $service:
        ensure     => 'running',
        enable     => true,
        hasstatus  => $tinyproxy::params::hasstatus,
        hasrestart => $tinyproxy::params::hasrestart,
        require    => Package[$package],
        subscribe  => Concat[$tinyproxy::params::configfile],
      }
    }
    'absent': {
      $version = $ensure
    }
    default: {
      fail("Unsupported ensure parameter ${ensure}. Valid values are: present, absent")
    }
  }

  package { $package:
    ensure => $version,
  }

  concat { $tinyproxy::params::configfile:
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package[$package],
  }
  concat::fragment { 'tinyproxy_main':
    target  => $tinyproxy::params::configfile,
    content => $template,
    source  => $config_source,
    order   => 10,
  }

  if $filter and is_array($filtercontent) {
    file { $filter:
      ensure  => 'present',
      content => join($filtercontent, "\n"),
      owner   => 'root',
      group   => $group,
      mode    => '0640',
      require => [Concat[$tinyproxy::params::configfile],Package[$package]],
      notify  => Service[$service],
    }
  }

  create_resources('tinyproxy::upstream', $upstreams)
  create_resources('tinyproxy::noupstream', $noupstreams)
  create_resources('tinyproxy::reversepath', $reversepaths)
}
