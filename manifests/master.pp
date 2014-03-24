class puppet::master (
  $manifestdir         = undef,
  $manifest            = undef,
  $modulepath          = $puppet::params::puppet_master_modulepath,
  $reports             = undef,
  $dns_alt_names       = undef,
  $storeconfigs        = undef,
  $storeconfig_backend = undef,
  $autosign            = undef,
  $puppetdb_server     = $puppet::params::puppet_db_masterconf_server,
  $puppetdb_port       = $puppet::params::puppet_db_masterconf_port,
  $puppetdb_soft       = $puppet::params::puppet_db_masterconf_soft,
  $masterserver        = undef,
  $report              = undef,
  $pluginsync          = undef,
  $environment         = undef,
  $certname            = undef,
  $agent_status        = $puppet::params::puppet_agent_service_status,
  $master_status       = $puppet::params::puppet_master_service_status,
  $rundir              = undef,
  $vardir              = undef,
  $ssldir              = undef,
) inherits puppet::params {

  # Definimos el fichero de configuracion principal
  concat { '/etc/puppet/puppet.conf':
    owner   => 'root',
    group   => 'root',
	mode    => '0644',
	require => Package[$puppet::params::puppet_master_package],
    notify   => [
	  Service[$puppet::params::puppet_master_service_name],
	  Service[$puppet::params::puppet_agent_service_name]
    ]
  }
  
  # Clase con la configuracion del main
  class { 'puppet::configmain':
    certname   => $certname,
    rundir     => $rundir,
    vardir     => $vardir,
    ssldir     => $ssldir,
  }

  # Instalacion de Master
  class {'puppet::master::install':
  }

  # Configuracion de Master
  class {'puppet::master::config':
    manifestdir          => $manifestdir,
	manifest             => $manifest,
    modulepath           => $modulepath,
	reports              => $reports,
    storeconfigs         => $storeconfigs,
    storeconfig_backend  => $storeconfig_backend,	
	dns_alt_names        => $dns_alt_names,
	autosign             => $autosign,
	puppetdb_server      => $puppetdb_server,
	puppetdb_port        => $puppetdb_port,
	puppetdb_soft        => $puppetdb_soft,
  }

  # Servicio Master
  class {'puppet::master::service':
    service_status => $master_status,
  }
  
  # Instalacion de agente
  class {'puppet::agent::install':
  }
  
  # Configuracion de agente
  class {'puppet::agent::config':
    masterserver   => $masterserver,
	report         => $report,
	pluginsync     => $pluginsync,
	certname       => $certname,
	environment    => $environment,
	service_status => $agent_status,
  }
  
  # Servicio de agente
  class {'puppet::agent::service':
    service_status => $service_status,
  }

}