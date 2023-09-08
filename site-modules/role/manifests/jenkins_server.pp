# This class is used to detect the sever os type, this will be used in conjunction with other classes that are OS specific 
# Intentional space
# review roles and profiles
class role::jenkins_server {
  include profile::base
  include profile::jenkins
}
