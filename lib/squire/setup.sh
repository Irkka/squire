require_relative $BASH_SOURCE 'setup/cleanup'
require_relative $BASH_SOURCE 'setup/configure'
require_relative $BASH_SOURCE 'setup/bootstrap'

function squire_setup() {
  echo 'Setting up a clean slate...'
  squire_cleanup
  echo 'Configuring Squire...'
  squire_configure
  echo 'Bootstrapping Squire...'
  squire_bootstrap
}
