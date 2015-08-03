class puppet::agent (
  $masterserver   = undef,
  $report         = undef,
  $pluginsync     = undef,
  $environment    = undef,
  $certname       = undef,
  $service_status = $puppet::params::puppet_agent_service_status,
  $service_enable = $puppet::params::puppet_agent_service_enable,
  $certname       = undef,
  $rundir         = undef,
  $vardir         = undef,
  $ssldir         = undef,
) inherits puppet::params {

  concat { '/etc/puppet/puppet.conf':
    owner   => 'root',
    group   => 'root',
	mode    => '0644',
    notify   => Service[$puppet::params::puppet_agent_service_name],
  }
  
  # Clase con la configuracion del main
  class { 'puppet::configmain':
    certname   => $certname,
    rundir     => $rundir,
    vardir     => $vardir,
    ssldir     => $ssldir,
  }
 
  # Instalacion de puppet agente
  class {'puppet::agent::install':
  }
  
  # Configuracion de agente
  class {'puppet::agent::config':
    masterserver   => $masterserver,
	report         => $report,
	pluginsync     => $pluginsync,
	certname       => $certname,
	environment    => $environment,
	service_status => $service_status,
  }
  
  # Servicio agente
  class {'puppet::agent::service':
    service_status => $service_status,
    service_enable => $service_enable,
  }
  
}
