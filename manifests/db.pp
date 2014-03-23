class puppet::db inherits puppet::params {

   class {'puppet::db::install':
   }
   
   class {'puppet::db::config':
   }
   
   class {'puppet::db::service':
   }
}