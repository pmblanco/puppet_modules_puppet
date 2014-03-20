class puppet::agent (
  $masterserver   = undef,
  $report         = undef,
  $pluginsync     = undef,
  $environment    = undef,
  $certname       = undef,
  $service_status = $puppet::params::puppet_agent_service_status
) inherits puppet::params {

  anchor { 'puppet::agent::begin':
    before        => Class['puppet::agent::install'],
  }

  class {'puppet::agent::install':
    require       => Anchor['puppet::agent::begin'],
  }
  
  class {'puppet::agent::config':
    masterserver  => $masterserver,
	report        => $report,
	pluginsync    => $pluginsync,
	certname      => $certname,
	environment   => $environment,
	require       => Class['puppet::agent::install'],
  }
  
  class {'puppet::agent::service':
    service_status => $service_status,
	require        => Class['puppet::agent::config'],
  }
  
  anchor {'puppet::agent::end':
    require        => Class['puppet::agent::service'],
  }

}