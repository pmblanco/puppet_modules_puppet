class puppet::agent::config::ubuntu (
  $service_status
) {

  if $service_status == 'running' {
    $filecontent = "START=yes"
  }
  else {
    $filecontent = "START=no"
  }	
	
  file {'ubuntu-puppet-agent-defaults-file':
    ensure   => file,
    path     => '/etc/default/puppet',
    owner    => 'root',
    group    => 'root',
    mode     => 0644,
    content  => $filecontent,
	notify  => Service[$puppet::params::puppet_agent_service_name],
  }

}