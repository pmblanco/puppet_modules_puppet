class puppet::configmain (
  $masterserver = undef,
  $certname = undef,
  $rundir = undef,
  $vardir = undef,
){

  if defined(Package["$puppet::params::puppet_agent_package"]) {
    $require_package = "Package[$puppet::params::puppet_agent_package]"
  }
  elsif defined(Package[$puppet::params::puppet_master_package]) {
    $require_package = "Package[$puppet::params::puppet_master_package]"
  }
  else {
    fail ("No sense call class puppet::configmain whitout puppet::master or puppet::agent classes")
  }

  if ! defined(Concat['/etc/puppet/puppet.conf']) {
    concat { '/etc/puppet/puppet.conf':
      owner   => 'root',
	  group   => 'root',
	  mode    => '0644',
	  require => $require_package,
    }
  }

  concat::fragment { 'puppet_conf_main':
    target  => '/etc/puppet/puppet.conf',
	content => template("${module_name}/puppet_main.conf.erb"),
	order   => '10',
  }

}