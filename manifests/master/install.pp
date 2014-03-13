class puppet::master::install {

  package { $puppet::params::puppet_master_package:
    ensure   => installed,
  }

}