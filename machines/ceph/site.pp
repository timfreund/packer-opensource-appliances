class { 'ceph':
  fsid        => generate('/usr/bin/uuidgen'),
  mon_host    => $::ipaddress_eth0,
  authentication_type => 'none',
  osd_pool_default_size => 1,
}

ceph::mon { 'a':
  public_addr => $::ipaddress_eth0,
  authentication_type => 'none',
}

ceph::osd { '/dev/vdb': }
