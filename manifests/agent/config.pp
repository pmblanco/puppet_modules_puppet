class puppet::agent::config {

  if ! defined(Concat['/etc/puppet/puppet.conf']) {
    concat { '/etc/puppet/puppet.conf':
      owner   => 'root',
	  group   => 'root',
	  mode    => '0644',
	  require => Package[$puppet::params::puppet_agent_package],
    }
  }
  
  concat::fragment { 'puppet_conf_agent':
    target  => '/etc/puppet/puppet.conf',
	content => "[agent]",
	order   => '10',
  }

}