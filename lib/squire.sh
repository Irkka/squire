#!/bin/bash
SQUIRE_APPLICATION_NAME='squire'

LOADED_BY_SQUIRE=()

function setup_squire() {
  SQUIRE_PATH=$(readlink -m ${BASH_SOURCE%/*})
  BASHLIB_PATH=${BASHLIB_PATH:-$SQUIRE_PATH:${HOME}/.local/lib}
  # Enable require functionality
  source "${SQUIRE_PATH}/squire/load.sh"
  source "${SQUIRE_PATH}/squire/require.sh"
}

setup_squire

require_relative $BASH_SOURCE 'squire/version'
require_relative $BASH_SOURCE 'squire/dependency_manager'

export SQUIRE_APPLICATION_NAME LOADED_BY_SQUIRE BASHLIB_PATH
