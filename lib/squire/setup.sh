require_relative 'setup/cleanup'
require_relative 'setup/configure'
require_relative 'setup/bootstrap'

function squire_setup() {
  echo 'Setting up a clean slate...'
  squire_cleanup
  echo 'Configuring Squire...'
  squire_configure
  echo 'Bootstrapping Squire...'
  squire_bootstrap
}
