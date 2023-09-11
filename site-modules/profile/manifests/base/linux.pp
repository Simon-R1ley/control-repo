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
}
