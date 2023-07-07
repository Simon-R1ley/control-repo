#
class profile::base::windows {
  # https://www.puppet.com/docs/puppet/8/types/group.html - use for group creation
  #user { 'Art Vandelay':
# ensure => present,
  #}
  notify { 'windows': }
  # Group admin creation
  group { 'Vandelay Industries Administrators':
    ensure         => present,
  }
}
