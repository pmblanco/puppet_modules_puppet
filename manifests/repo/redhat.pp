class puppet::repo::redhat {

	file { 'rpm-gpg-key':
	  ensure   => file,
	  path     => '/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
	  owner    => 'root',
	  group    => 'root',
	  source   => "puppet:///modules/${module_name}/repo/RPM-GPG-KEY-puppetlabs",
	}

	yumrepo { 'puppetlabs-deps':
	  baseurl  => 'http://yum.puppetlabs.com/el/6/dependencies/$basearch',
	  descr    => 'Puppet Labs Dependencies El 6 - $basearch',
	  enabled  => '1',
	  gpgcheck => '1',
	  gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
	}
	yumrepo { 'puppetlabs-deps-source':
	  baseurl  => 'http://yum.puppetlabs.com/el/6/dependencies/SRPMS',
	  descr    => 'Puppet Labs Source Dependencies El 6 - $basearch - Source',
	  enabled  => '0',
	  gpgcheck => '1',
	  gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
	}
	yumrepo { 'puppetlabs-devel':
	  baseurl  => 'http://yum.puppetlabs.com/el/6/devel/$basearch',
	  descr    => 'Puppet Labs Devel El 6 - $basearch',
	  enabled  => '0',
	  gpgcheck => '1',
	  gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
	}
	yumrepo { 'puppetlabs-devel-source':
	  baseurl  => 'http://yum.puppetlabs.com/el/6/devel/SRPMS',
	  descr    => 'Puppet Labs Devel El 6 - $basearch - Source',
	  enabled  => '0',
	  gpgcheck => '1',
	  gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
	}
	yumrepo { 'puppetlabs-products':
	  baseurl  => 'http://yum.puppetlabs.com/el/6/products/$basearch',
	  descr    => 'Puppet Labs Products El 6 - $basearch',
	  enabled  => '1',
	  gpgcheck => '1',
	  gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
	}
	yumrepo { 'puppetlabs-products-source':
	  baseurl        => 'http://yum.puppetlabs.com/el/6/products/SRPMS',
	  descr          => 'Puppet Labs Products El 6 - $basearch - Source',
	  enabled        => '0',
	  failovermethod => 'priority',
	  gpgcheck       => '1',
	  gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
	}

}
