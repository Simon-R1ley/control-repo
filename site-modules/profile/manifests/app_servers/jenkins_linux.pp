# Jenkins installation on linux - Tested on cent os7 - 
class profile::app_servers::jenkins_linux {
# Notification for jenkins linux 
  notify { 'jenkinslinux':
  }
  # Installs yum and open jdk 11, ensures the latest
  package {['yum','java-11-openjdk']:
    ensure => latest,
  }
  # Jenkins pkg url added to yumrepo
  yumrepo { 'jenkins':
    ensure   => 'present',
    baseurl  => 'http://pkg.jenkins.io/redhat-stable',
    gpgkey   => 'https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key'
    descr    => 'Jenkins-stable',
    gpgcheck => '1',
    provider => 'inifile',
  }
  # This ensures that Jenkins prerequsites are avalible prior to installing the latest version of jenkins 
  package { 'jenkins':
    ensure  => latest,
    require => [Package['java-11-openjdk'], Yumrepo['jenkins']],
  }
}
