SQUIRE_APPLICATION_NAME='squire'

SQUIRE_PATH=$(readlink -m ${0%/*})
BASHLIB_PATH=${BASHLIB_PATH:-$(readlink -m ${SQUIRE_PATH}):${HOME}/.local/lib}
LOADED_BY_SQUIRE=()

export SQUIRE_APPLICATION_NAME SQUIRE_APPLICATION_NAME LOADED_BY_SQUIRE BASHLIB_PATH

function setup_squire() {
  # Enable require functionality
  source "${SQUIRE_PATH}/squire/load.sh"
  source "${SQUIRE_PATH}/squire/require.sh"

  require_relative $SQUIRE_PATH 'squire/version'
}

setup_squire
