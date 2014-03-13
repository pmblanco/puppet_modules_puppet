class puppet::repo::ubuntu {

  case $::operatingsystemrelease {
    '12.04': {
      $ubuntu_release  = 'precise'
    } 
    default: {
      fail ("Version $::operatingsystemrelease of Ubuntu is not supported")
    }
  }

  apt::source { 'puppetlabs-repo':
    location     => "$puppet_source_repo_url",
    release      => "$ubuntu_release",
    repos        => "$puppet_source_repos",
  }

}
