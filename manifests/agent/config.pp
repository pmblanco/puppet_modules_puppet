class puppet::agent::config (
  $masterserver = undef,
  $report       = undef,
  $pluginsync   = undef,
  $certname     = undef,
  $environment  = undef,
){

  include puppet::puppetconf
  
  concat::fragment { 'puppet_conf_agent':
    target  => '/etc/puppet/puppet.conf',
	content => template("${module_name}/puppet_agent.conf.erb"),
	order   => '20',
  }

}