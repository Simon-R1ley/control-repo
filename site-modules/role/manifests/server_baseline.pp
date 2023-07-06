#@This class is used to detect the sever os type, this will be used in conjunction with other classes that are OS specific 
# Intentional space
class role::server_baseline {
  include profile::windows
  include profile::linux

  if $facts['os']['family'] == 'windows' {
    notice('This is a Windows server')
  } else {
    notice('This is a Linux server')
  }
}
