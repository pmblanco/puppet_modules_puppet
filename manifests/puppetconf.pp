class puppet::puppetconf {
  
  concat { '/etc/puppet/puppet.conf':
    owner   => 'root',
    group   => 'root',
	mode    => '0644',
  }

}