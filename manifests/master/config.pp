class puppet::master::config (
  $manifestdir     = undef,
  $manifest        = undef,
  $modulepath      = undef,
  $reports         = undef,
  $dns_alt_names   = undef,
  $autosign        = undef,
  $puppetdb_server = undef,
  $puppetdb_port   = undef,
  $puppetdb_soft   = undef,
){

  # Validamos el valor de $puppetdb_soft, si no es true cualquier otra cosa es false
  if $puppetdb_soft == 'true' {
 	$puppetdb_soft_final = 'false'
  }
  else { 
	$puppetdb_soft_final = 'false'
  }
  
  concat::fragment { 'puppet_conf_master':
    target  => '/etc/puppet/puppet.conf',
	content => template("${module_name}/puppet_master.conf.erb"),
	order   => '30',
  }
 
  # Configuracion del fichero autosign
  if is_array($autosign) {
    file { 'puppet-autosign-file':
      ensure    => file,
	  path      => '/etc/puppet/autosign.conf',
	  owner     => 'root',
	  group     => 'root',
	  mode      => 0644,
	  content   => join($autosign,"\n"),
      notify    => Service[$puppet::params::puppet_master_service_name],
	}
  }
  
  # Configuracion del fichero para conectar contra puppetdb
  if $puppetdb_server {
    file { 'puppet-puppetdb-file':
	  ensure    => file,
	  path      => '/etc/puppet/puppetdb.conf',
	  owner     => 'root',
	  group     => 'root',
	  mode      => 0644,
	  content   => "[main]\n  server = ${puppetdb_server}\n  port = ${puppetdb_port}\n  soft_write_failure = $puppetdb_soft_final",
	} 
  }
  
}