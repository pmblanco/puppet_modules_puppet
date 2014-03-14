class puppet::params {
  
  case $::operatingsystem {
  
    'Ubuntu': {
	  $puppet_source_repo_url   = 'http://apt.puppetlabs.com'
	  $puppet_source_repo_key   = '4BD6EC30'
	  $puppet_source_repos      = 'main dependencies'
	  $puppet_master_package    = 'puppetmaster'
	  $puppet_agent_package     = 'puppet'
	}
	
	default: {
	  fail ("$::operatingsystem $::operatingsystemversion is not supported")
	}

  }
}
