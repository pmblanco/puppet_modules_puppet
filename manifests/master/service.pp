class puppet::master::service (
  $service_status,
  $service_enable,
) {

  service { $puppet::params::puppet_master_service_name:
    ensure   => $service_status,
    enable   => $service_enable,
  }

}
