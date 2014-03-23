class puppet::db (
  $db_protocol = $puppet::params::puppet_db_protocol,
  $db_name     = $puppet::params::puppet_db_name,

) inherits puppet::params {

   class {'puppet::db::install':
   }
   
   class {'puppet::db::config':
     db_protocol    => $db_protocol,
	 db_name        => $db_name,
   }
   
   class {'puppet::db::service':
   }

}