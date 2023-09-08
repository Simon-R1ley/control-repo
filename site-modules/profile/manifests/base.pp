# This class is used to detect the sever os type, this will be used in conjunction with other classes that are OS specific 
# Intentional space
# review roles and profiles
class profile::base {
  case $facts['kernel'] {
    'windows': {
      include profile::base::windows
    }
    'Linux':  {
      include profile::base::linux
    }
    default:  {
      fail('This OS is not supported')
    }
  }
}
