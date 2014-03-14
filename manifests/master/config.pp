class puppet::master::config (
  $puppet_master_modulepath    = $puppet::params::puppet_master_modulepath
){

  include puppet::configmain
  
  if ! defined(Concat['/etc/puppet/puppet.conf']) {
    concat { '/etc/puppet/puppet.conf':
      owner   => 'root',
	  group   => 'root',
	  mode    => '0644',
	  require => Package[$puppet::params::puppet_master_package],
    }
  }
  
  concat::fragment { 'puppet_conf_master':
    target  => '/etc/puppet/puppet.conf',
	content => template("${module_name}/puppet_master.conf.erb"),
	order   => '30',
  }

}