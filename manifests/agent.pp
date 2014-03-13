class puppet::agent inherits puppet::params {
  class {'puppet::agent::install':
  }
  class {'puppet::agent::config':
  }
}