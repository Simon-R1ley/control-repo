class profile::app_server::jenkins {
# This notifies linix
  notify { 'linux':
  }
  node 'hostname.example.com' {
    include jenkins
  }
}
