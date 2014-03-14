class puppet::repo::ubuntu {

  case $::operatingsystemrelease {
    '12.04': {
      $ubuntu_release  = 'precise'
    } 
    default: {
      fail ("Version $::operatingsystemrelease of Ubuntu is not supported")
    }
  }
  
  apt::key { 'puppetlabs':
    key        => '4BD6EC30',
    key_server => 'pgp.mit.edu',
  }

  apt::source { 'puppetlabs-repo':
    location     => "$puppet::params::puppet_source_repo_url",
    release      => "$ubuntu_release",
    repos        => "$puppet::params::puppet_source_repos",
	key          => "$puppet::params::puppet_source_repo_key",
	key_server   => "pgp.mit.edu",
  }

}
