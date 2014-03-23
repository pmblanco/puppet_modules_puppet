class puppet::agent::config (
  $masterserver   = undef,
  $report         = undef,
  $pluginsync     = undef,
  $certname       = undef,
  $environment    = undef,
  $service_status,
){

  include puppet::puppetconf

  concat::fragment { 'puppet_conf_agent':
    target  => '/etc/puppet/puppet.conf',
	content => template("${module_name}/puppet_agent.conf.erb"),
	order   => '20',
	notify  => Service[$puppet::params::puppet_agent_service_name],
  }

  # Anadimos casos especiales para cada sistema operativo
  case $::operatingsystem {
    'Ubuntu': {
	  class {'puppet::agent::config::ubuntu':
	    service_status  => $service_status
	  }
	}
  }

}