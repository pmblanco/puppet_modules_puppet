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
	  $puppet_db_service             = 'puppetdb'
	}

	default: {
	  fail ("$::operatingsystem $::operatingsystemversion is not supported")
	}

  }

  $puppet_master_modulepath        = '/etc/puppet/modules:/usr/share/puppet/modules'
  $puppet_master_service_name      = 'puppetmaster'
  $puppet_master_service_status    = 'running'
  $puppet_agent_service_name       = 'puppet'
  $puppet_agent_service_status     = 'running'
  $puppet_db_protocol              = 'hsqldb'
  $puppet_db_name                  = 'file:/var/lib/puppetdb/db/db;hsqldb.tx=mvcc;sql.syntax_pgs=true'

}
