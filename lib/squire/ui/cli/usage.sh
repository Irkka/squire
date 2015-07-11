require_relative '../../meta.sh'

function squire_usage() {
  squire_version
  cat <<USAGE
  # To locate squire installation and load it up
  eval \$(squire init)
  # To install or uninstall local or global libraries
  squire <install (-g)|uninstall (-g)>
USAGE

  return 1
}

export -f squire_usage
