#
class base::windows {
  # https://www.puppet.com/docs/puppet/6/types/group.html - use for group creation
  #user { 'Art Vandelay':
# ensure => present,
  #}
  notify { 'windows':
  }
}
