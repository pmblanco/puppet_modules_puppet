class puppet::master (
  $manifestdir   = undef,
  $manifest      = undef,
  $modulepath    = $puppet::params::puppet_master_modulepath,
  $reports       = undef,
  $dns_alt_names = undef,
  $service_status = $puppet::params::puppet_master_service_status
) inherits puppet::params {

  anchor { 'puppet::master::begin':
    before         => Class['puppet::master::install'],
  }

  class {'puppet::master::install':
    require        => Anchor['puppet::master::begin'],
  }

  class {'puppet::master::config':
    manifestdir    => $manifestdir,
	manifest       => $manifest,
    modulepath     => $modulepath,
	reports        => $reports,
	dns_alt_names  => $dns_alt_names,
	require        => Class['puppet::master::install'],
  }

  class {'puppet::master::service':
    service_status => $service_status,
	require        => Class['puppet::master::config'],
  }

  anchor { 'puppet::master::end':
    require        => Class['puppet::master::service'],
  }

}