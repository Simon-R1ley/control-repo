# Jenkins installation on linux - Tested on cent os7 - 
class profile::app_servers::jenkins_linux {
# Notification for jenkins linux 
  notify { 'jenkinslinux':
  }
  # Installs yum and open jdk 11, ensures the latest - Secure by design as Java 11 is updated
  # but will maintain the security patches
  package {['yum','java-11-openjdk']:
    ensure => latest,
  }
  # Jenkins pkg url added to yumrepo with gpg key 
  yumrepo { 'jenkins':
    ensure   => 'present',
    baseurl  => 'http://pkg.jenkins.io/redhat-stable',
    gpgkey   => 'https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key',
    descr    => 'Jenkins-stable',
    gpgcheck => '1',
    provider => 'inifile',
  }
  # This ensures that Jenkins prerequsites are avalible prior to installing the latest version of jenkins 
  # sudo cat /var/lib/jenkins/secrets/initialAdminPassword - possible improvement to show password
  # Firewall change to allow port 8000
  # firewall-cmd --zone=public --add-service http
  # firewall-cmd --zone=public --add-port=8000/tcp
  package { 'jenkins':
    ensure  => latest,
    command => 'jenkins --httpPort=8000', 'firewall-cmd --zone=public --add-service http', 'firewall-cmd --zone=public --add-port=8000/tcp',
    require => [Package['java-11-openjdk'], Yumrepo['jenkins']],
  }
}
