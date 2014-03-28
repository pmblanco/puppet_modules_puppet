class puppet::db (
  $db_protocol     = $puppet::params::puppet_db_protocol,
  $db_name         = $puppet::params::puppet_db_name,
  $jetty_host      = $puppet::params::puppet_db_jetty_host,
  $jetty_port      = $puppet::params::puppet_db_jetty_port,
  $jetty_ssl_host  = $puppet::params::puppet_db_jetty_ssl_host,
  $jetty_ssl_port  = $puppet::params::puppet_db_jetty_ssl_port,
  $jetty_cert_file = $puppet::params::puppet_db_jetty_cert_file,
  $jetty_key_file  = $puppet::params::puppet_db_jetty_key_file,
  $jetty_ca_file   = $puppet::params::puppet_db_jetty_ca_file,

) inherits puppet::params {

   class {'puppet::db::install':
   }
   
   class {'puppet::db::config':
     db_protocol     => $db_protocol,
	 db_name         => $db_name,
	 jetty_host      => $jetty_host,
	 jetty_port      => $jetty_port,
	 jetty_ssl_host  => $jetty_ssl_host,
	 jetty_ssl_port  => $jetty_ssl_port,
	 jetty_cert_file => $jetty_cert_file,
	 jetty_key_file  => $jetty_key_file,
	 jetty_ca_file   => $jetty_ca_file,
   }
   
   class {'puppet::db::service':
   }

}