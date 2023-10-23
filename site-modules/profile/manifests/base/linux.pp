#
class profile::base::linux (
  Array $ntpservers,
) {
# This notifies linix
  notify { 'linux':
  }

  class { 'ntp':
    servers => $ntpservers,
  }

  class { 'ssh' :
    forward_x11 => 'yes',
  }
}
