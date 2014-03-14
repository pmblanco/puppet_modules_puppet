class puppet::configmain {

  if ! defined(Concat['/etc/puppet/puppet.conf']) {
    concat { '/etc/puppet/puppet.conf':
      owner   => 'root',
	  group   => 'root',
	  mode    => '0644',
	  require => Package[$puppet::params::puppet_agent_package],
    }
  }

  concat::fragment { 'puppet_conf_main':
    target  => '/etc/puppet/puppet.conf',
	content => template("${module_name}/puppet_main.conf.erb"),
	order   => '10',
  }

}