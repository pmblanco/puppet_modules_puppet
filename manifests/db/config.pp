class puppet::db::config (
  $db_protocol,
  $db_name,
  $jetty_host,
  $jetty_port,
  $jetty_ssl_host,
  $jetty_ssl_port,
  $jetty_cert_file,
  $jetty_key_file,
  $jetty_ca_file,
) {

  case $db_protocol {
    'hsqldb': {
	  $db_driver = 'org.hsqldb.jdbcDriver'
	}
	'postgresql': {
	  $db_driver = 'org.postgresql.Driver'
	}
	default: {
	  fail("Protocol $db_protocol not supported")
	}
  }
  
  file { 'puppetdb-config-database-ini':
    ensure    => file,
	path      => $puppet::params::puppet_db_config_database_ini,
	owner     => 'puppetdb',
	group     => 'puppetdb',
	mode      => 0640,
	content   => template("$module_name/db/database.ini.erb"),
	require   => Package[$puppet::params::puppet_db_package],
	notify    => Service[$puppet::params::puppet_db_service],
  }
  
  file { 'puppetdb-ssl-directory':
    ensure    => directory,
	path      => '/etc/puppetdb/ssl',
	owner     => 'puppetdb',
	group     => 'puppetdb',
	mode      => 0750,
	require   => Package[$puppet::params::puppet_db_package],
  }
  
  file { 'puppetdb-ssl-cert-file':
    ensure    => file,
	path      => '/etc/puppetdb/ssl/puppetdb.crt',
	owner     => 'puppetdb',
	group     => 'puppetdb',
	mode      => 0600,
	source    => $jetty_cert_file,
	require   => File['puppetdb-ssl-directory']
  }
  
  file { 'puppetdb-ssl-key-file':
    ensure    => file,
	path      => '/etc/puppetdb/ssl/puppetdb.key',
	owner     => 'puppetdb',
	group     => 'puppetdb',
	mode      => 0600,
	source    => $jetty_key_file,
	require   => File['puppetdb-ssl-directory']
  }
  
  file { 'puppetdb-ssl-ca-file':
    ensure    => file,
	path      => '/etc/puppetdb/ssl/ca.crt',
	owner     => 'puppetdb',
	group     => 'puppetdb',
	mode      => 0600,
	source    => $jetty_ca_file,
	require   => File['puppetdb-ssl-directory']
  }

  file { 'puppetdb-config-jetty-ini':
    ensure    => file,
	path      => $puppet::params::puppet_db_config_jetty_ini,
	owner     => 'puppetdb',
	group     => 'puppetdb',
	mode      => 0640,
	content   => template("$module_name/db/jetty.ini.erb"),
	notify    => Service[$puppet::params::puppet_db_service],
  }
}