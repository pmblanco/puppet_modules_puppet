class puppet::master::config (
  $manifestdir    = undef,
  $manifest       = undef,
  $modulepath     = undef,
  $reports        = undef,
  $dns_alt_names  = undef,
){
  
  include puppet::puppetconf
  
  concat::fragment { 'puppet_conf_master':
    target  => '/etc/puppet/puppet.conf',
	content => template("${module_name}/puppet_master.conf.erb"),
	order   => '30',
	notify  => Service[$puppet::params::puppet_master_service_name],
  }

}