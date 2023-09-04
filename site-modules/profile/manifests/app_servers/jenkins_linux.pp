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
    require => [Package['java-11-openjdk'], Yumrepo['jenkins']],
  }

  service { 'jenkins':
    ensure    => 'running',
    enable    => 'true',
# start     => 'systemctl start /usr/bin/jenkins --httpPort=8000',
    subscribe => File_line['JENKINS_PORT'],
  }
#require => Service['firewalld'],
#
# Resource Type List - Reff: https://www.puppetmodule.info/modules/puppetlabs-stdlib/4.25.1/puppet_types/file_line
  file { '/etc/systemd/system/jenkins.service.d/overide.conf':
    ensure => file,
    source => 'puppet:///modules/profile/files/overide.conf',
  }

  package { 'firewalld':
    ensure => 'installed',
    before => File['/usr/lib/firewalld/services/jenkins.xml'],
  }

  service { 'firewalld':
    ensure  => 'stopped',
    enable  => true,
    require => Package['firewalld'],
  }

# File resouce
  #Firewall port opening for port 8000 - jenkins custom port only 
  # Developing notes - The Puppet source - puppet:/// ... needs to be created - this is done by
  # editing the fileserverconfig = /etc/puppetlabs/puppet/fileserver.conf on the PE master.
  # For more information see: https://www.puppet.com/docs/puppet/6/config_file_fileserver.html
  # 
  file { '/usr/lib/firewalld/services/jenkins.xml':
    ensure  => file,
    source  => 'puppet:///_files/jenkins.xml',
    mode    => '0600',
    owner   => 'root',
    require => Service['firewalld'],
  }

  # Notify of PW at location  use varible!
}
