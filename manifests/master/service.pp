class puppet::master::service (
  $service_status
) {

  service { $puppet::params::puppet_master_service_name:
    ensure   => $service_status,
  }

}