class puppet::master (
  $modulepath    = $puppet::params::puppet_master_modulepath,
  $reports       = undef,
  $dns_alt_names = undef,
) inherits puppet::params {
  
  class {'puppet::master::install':
  }
  
  class {'puppet::master::config':
    modulepath    => $modulepath,
	reports       => $reports,
	dns_alt_names => $dns_alt_names,
  }
  
}
