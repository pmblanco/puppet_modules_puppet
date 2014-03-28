class puppet::configmain (
  $certname     = undef,
  $rundir       = undef,
  $vardir       = undef,
  $ssldir       = undef,
){

  concat::fragment { 'puppet_conf_main':
    target  => '/etc/puppet/puppet.conf',
	content => template("${module_name}/puppet_main.conf.erb"),
	order   => '10',
  }

}