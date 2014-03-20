define puppet::environment (
  $modulepath,
  $manifest,
  $manifestdir,
  $templatedir = undef,
){

  if ! defined(Package[$puppet::params::puppet_master_package]) {
    fail ("No sense call class puppet::environment whitout puppet::master")
  }

  concat::fragment { "puppet_conf_environment_${name}":
    target  => '/etc/puppet/puppet.conf',
	content => template("${module_name}/puppet_environment.conf.erb"),
	order   => '50',
  }
  
}