class puppet::repo inherits puppet::params {

  case $::operatingsystem{
    'Ubuntu': {
      class {'puppet::repo::ubuntu':
      }
    }
	
	'CentOS','RedHat': {
	  class {'puppet::repo::redhat':
	  }
	}
	
  }

}
