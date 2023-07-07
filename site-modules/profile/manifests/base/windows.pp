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
  user {'Art Vandelay':
    ensure          => present,
    groups          => ['Administrators', 'Vandelay Industries Administrators'],
    comment         => 'Lab use',
  }
# User creation - https://www.puppet.com/docs/puppet/7/types/file.html
# Windows specfic file permissions - https://www.puppet.com/docs/puppet/7/resources_file_windows.html
  file { 'C:/adminTools/':
    ensure => 'directory',
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
}
