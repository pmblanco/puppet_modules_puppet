class puppet::agent::service (
  $service_status
) {

  service { $puppet::params::puppet_agent_service_name:
    ensure   => $service_status,
  }

}