# This class is used to detect the sever os type, this will be used in conjunction with other classes that are OS specific 
# Intentional space
# review roles and profiles
class role::server_baseline {
  case $facts['kernel'] {
    'windows': {
      include profile::base::windows
    }
    'Linux':  {
      include profile::base::linux
    }
    'JenkinsLinux': {
#      include profile::app_servers::jenkins_linux
    
    }
    default:  {
      fail('This OS is not supported')
    }
  }
}
