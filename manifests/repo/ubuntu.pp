class puppet::repo::ubuntu {

  case $::operatingsystemrelease {
    '12.04': {
      $ubuntu_release  = 'precise'
    } 
    default: {
      fail ("Version $::operatingsystemrelease of Ubuntu is not supported")
    }
  }
  
  apt::source { 'puppetlabs':
    location   => "$puppet::params::puppet_source_repo_url",
    repos      => "$puppet::params::puppet_source_repos",
    key        => "$puppet::params::puppet_source_repo_key",
    key_server => "$puppet::params::puppet_source_repo_key_server",
  }

}
