#@This class is used to detect the sever os type, this will be used in conjunction with other classes that are OS specific 
# Intentional space
class role::server_baseline {
  if $facts['os']['family'] == 'windows' {
    notice('This is a Windows server')
    include profile::base::windows
  } else {
    notice('This is a Linux server')
    include profile::base::linux
  }
}
