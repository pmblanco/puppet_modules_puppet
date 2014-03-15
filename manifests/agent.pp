class puppet::agent (
  $masterserver  = undef,
  $report        = undef,
  $pluginsync    = undef,
  $environment   = undef,
  $certname      = undef
) inherits puppet::params {

  class {'puppet::agent::install':
  }
  
  class {'puppet::agent::config':
    masterserver  => $masterserver,
	report        => $report,
	pluginsync    => $pluginsync,
	certname      => $certname,
  }
  
}