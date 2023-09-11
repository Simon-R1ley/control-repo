#
class profile::jenkins (
  String $jenkinsport,
) {
  class { 'jenkins':
    jenkinsport => $jenkinsport,
  }
}
