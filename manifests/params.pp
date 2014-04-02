class puppet::params {

  case $::operatingsystem {

    'Ubuntu': {
	  $puppet_source_repo_url        = 'http://apt.puppetlabs.com'
	  $puppet_source_repo_key        = '4BD6EC30'
	  $puppet_source_repo_key_server = 'pgp.mit.edu'
	  $puppet_source_repos           = 'main dependencies'
	  $puppet_master_package         = 'puppetmaster'
	  $puppet_agent_package          = 'puppet'
	  $puppet_db_package             = 'puppetdb'
	  $puppet_db_terminus_package    = 'puppetdb-terminus'
	  $puppet_db_config_database_ini = '/etc/puppetdb/conf.d/database.ini'
  	  $puppet_db_config_jetty_ini    = '/etc/puppetdb/conf.d/jetty.ini'
	  $puppet_db_service             = 'puppetdb'
	}
	
	'CentOS','RedHat': {
	  $puppet_master_package         = 'puppet-server'
	  $puppet_agent_package          = 'puppet'
	  $puppet_db_package             = 'puppetdb'
	  $puppet_db_terminus_package    = 'puppetdb-terminus'
	  $puppet_db_config_database_ini = '/etc/puppetdb/conf.d/database.ini'
  	  $puppet_db_config_jetty_ini    = '/etc/puppetdb/conf.d/jetty.ini'
	  $puppet_db_service             = 'puppetdb'	
	}

	default: {
	  fail ("$::operatingsystem $::operatingsystemversion is not supported")
	}

  }

  # Configuraciones de puppet master
  $puppet_master_modulepath        = '/etc/puppet/modules:/usr/share/puppet/modules'
  $puppet_master_service_name      = 'puppetmaster'
  $puppet_master_service_status    = 'running'
  
  # Configuraciones de puppet agent
  $puppet_agent_service_name       = 'puppet'
  $puppet_agent_service_status     = 'running'
  
  # Configuraciones de puppetdb
  $puppet_db_protocol              = 'hsqldb'
  $puppet_db_name                  = 'file:/var/lib/puppetdb/db/db;hsqldb.tx=mvcc;sql.syntax_pgs=true'
  $puppet_db_jetty_host            = '0.0.0.0'
  $puppet_db_jetty_port            = '8080'
  $puppet_db_jetty_ssl_host        = '0.0.0.0'
  $puppet_db_jetty_ssl_port        = '8081'
  $puppet_db_jetty_cert_file       = "/var/lib/puppet/ssl/certs/${::fqdn}.pem"
  $puppet_db_jetty_key_file        = "/var/lib/puppet/ssl/private_keys/${::fqdn}.pem"
  $puppet_db_jetty_ca_file         = "/var/lib/puppet/ssl/certs/ca.pem"
  
  # Configuraciones de puppetmaster de conexion a puppetdb
  $puppet_db_masterconf_server     = undef
  $puppet_db_masterconf_port       = 8081
  $puppet_db_masterconf_soft       = false

}
