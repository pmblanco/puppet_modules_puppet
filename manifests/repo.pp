class puppet::repo inherits puppet::params {

  case $::operatingsystem{
    Ubuntu: {
      class {'puppet::repo::ubuntu':
      }
    }
  }
}
