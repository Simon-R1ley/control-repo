# Jenkins installation on linux - Tested on cent os7 - 
# 
# 
# 
# 

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
    command => 'jenkins --httpPort=8000',
    require => [Package['java-11-openjdk'], Yumrepo['jenkins']],
  }

  package { 'firewalld':
    ensure => 'installed',
  }

  service { 'firewalld':
    ensure => 'running',
    enable => true,
    require => Package['firewalld'],
  }

# File resouce
  #Firewall port opening for port 8000 - jenkins custom port only 
  file { '/usr/lib/firewalld/services/jenkins.xml':
    ensure => "present",
    #source => 'puppet:///modules/profile/files/jenkins.xml',
    source => '/etc/puppetlabs/code/environments/production/site-modules/profile/files/jenkins.xml'
    mode   => '0600',
    owner  => 'root',
  }
  # Source Jenking.xml - puppet:///modules/profile/jenkins.xml
  # Notify exec

# Excec
  # Refresh if Only true
  # firewall-cmd --reload
}
