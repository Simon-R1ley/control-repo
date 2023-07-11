#
class profile::base::windows {
  # https://www.puppet.com/docs/puppet/8/types/group.html - use for group creation
  #user { 'Art Vandelay':
# ensure => present,
  #}
  notify { 'windows': }
  # Group admin creation
  group { 'Vandelay Industries Administrators':
    ensure         => present,
  }
  user { 'Art Vandelay':
    ensure  => present,
    groups  => ['Vandelay Industries Administrators'],
    comment => 'Lab use',
  }
# User creation - https://www.puppet.com/docs/puppet/7/types/file.html
# Windows specfic file permissions - https://www.puppet.com/docs/puppet/7/resources_file_windows.html
  file { 'C:/adminTools/':
    ensure => 'directory',
    mode   => '0660',
    owner  => 'Art Vandelay',
    group  => 'Administrators',
  }
  # Windows folder permissions using ACL module - https://forge.puppet.com/modules/puppetlabs/acl/readme
  acl { 'c:/adminTools':
    target                     => 'c:/adminTools',
    purge                      => false,
    permissions                => [
      { identity => 'Art Vandelay', rights => ['full'], perm_type=> 'allow', child_types => 'all', affects => 'all' },
      { identity => 'Vandelay Industries Administrators', rights => ['read','execute'], perm_type=> 'allow', child_types => 'all', affects => 'all' }
    ],
    owner                      => 'Art Vandelay', #Creator_Owner specific, doesn't manage unless specified
    group                      => 'Vandelay Industries Administrators', #Creator_Group specific, doesn't manage unless specified
    inherit_parent_permissions => true,
  }
  # Registry for IIS 
  registry_value { 'HKLM\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\IEHarden':
    ensure   => 'present',
    data     => [0],
    provider => 'registry',
    type     => 'dword',
  }
  # Shutdown event tracker
  registry_value { 'HKLM\Software\Microsoft\Windows\CurrentVersion\Reliability\ShutdownReasonUI':
    ensure   => 'present',
    data     => [0],
    provider => 'registry',
    type     => 'dword',
  }
  # Download using regular puppet module
  archive { 'C:\adminTools\MobaXterm_Portable_v23.2.zip':
    ensure => present,
    source => 'https://download.mobatek.net/2322023060714555/MobaXterm_Portable_v23.2.zip',
    user   => 0,
    group  => 0,
  }
  include chocolatey
}
