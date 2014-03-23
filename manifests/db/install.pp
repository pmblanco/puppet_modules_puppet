class puppet::db::install {

  package { $puppet::params::puppet_db_pacakge:
    ensure  => installed,
  }
  
  package { $puppet::params::puppet_db_terminus_package:
    ensure  => installed,
  }

}