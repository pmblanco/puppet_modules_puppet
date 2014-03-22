class puppet::master::config (
  $manifestdir    = undef,
  $manifest       = undef,
  $modulepath     = undef,
  $reports        = undef,
  $dns_alt_names  = undef,
  $autosign       = undef,
){
  
  include puppet::puppetconf
  
  concat::fragment { 'puppet_conf_master':
    target  => '/etc/puppet/puppet.conf',
	content => template("${module_name}/puppet_master.conf.erb"),
	order   => '30',
	notify  => Service[$puppet::params::puppet_master_service_name],
  }
 
  # Configuración del fichero autosign
  if is_array($autosign) {
    file { 'puppet-autosign-file':
      ensure    => file,
	  path      => '/etc/puppet/autosign.conf',
	  owner     => 'root',
	  group     => 'root',
	  mode      => 0644,
	  content   => join($autosign,"\n"),
      notify  => Service[$puppet::params::puppet_master_service_name],
	}
  }
  
}