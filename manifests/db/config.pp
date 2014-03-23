class puppet::db::config (
  $db_protocol,
  $db_name,
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

}