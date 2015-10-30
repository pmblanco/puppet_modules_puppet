class puppet::repo::redhat {



	file { 'rpm-gpg-key':
	  ensure   => file,
	  path     => '/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
	  owner    => 'root',
	  group    => 'root',
	  source   => "puppet:///modules/${module_name}/repo/RPM-GPG-KEY-puppetlabs",
	}

	yumrepo { 'puppetlabs-deps':
	  baseurl  => "http://yum.puppetlabs.com/el/${::operatingsystemmajrelease}/dependencies/\$basearch",
	  descr    => "Puppet Labs Dependencies El ${::operatingsystemmajrelease} - \$basearch",
	  enabled  => '1',
	  gpgcheck => '1',
	  gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
	}
	yumrepo { 'puppetlabs-deps-source':
	  baseurl  => "http://yum.puppetlabs.com/el/${::operatingsystemmajrelease}/dependencies/SRPMS",
	  descr    => "Puppet Labs Source Dependencies El ${::operatingsystemmajrelease} - \$basearch - Source",
	  enabled  => '0',
	  gpgcheck => '1',
	  gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
	}
	yumrepo { 'puppetlabs-devel':
	  baseurl  => "http://yum.puppetlabs.com/el/${::operatingsystemmajrelease}/devel/\$basearch",
	  descr    => "Puppet Labs Devel El ${::operatingsystemmajrelease} - \$basearch",
	  enabled  => '0',
	  gpgcheck => '1',
	  gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
	}
	yumrepo { 'puppetlabs-devel-source':
	  baseurl  => "http://yum.puppetlabs.com/el/${::operatingsystemmajrelease}/devel/SRPMS",
	  descr    => "Puppet Labs Devel El ${::operatingsystemmajrelease} - \$basearch - Source",
	  enabled  => '0',
	  gpgcheck => '1',
	  gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
	}
	yumrepo { 'puppetlabs-products':
	  baseurl  => "http://yum.puppetlabs.com/el/${::operatingsystemmajrelease}/products/\$basearch",
	  descr    => "Puppet Labs Products El ${::operatingsystemmajrelease} - \$basearch",
	  enabled  => '1',
	  gpgcheck => '1',
	  gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
	}
	yumrepo { 'puppetlabs-products-source':
	  baseurl        => "http://yum.puppetlabs.com/el/${::operatingsystemmajrelease}/products/SRPMS",
	  descr          => "Puppet Labs Products El ${::operatingsystemmajrelease} - \$basearch - Source",
	  enabled        => '0',
	  failovermethod => 'priority',
	  gpgcheck       => '1',
	  gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
	}

}
