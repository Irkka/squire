#!/bin/bash
# @author Ilkka Hakkarainen <ilkka.hakkarainen@cs.helsinki.fi>

# The authoritative source of this library's name.
SQUIRE_APPLICATION_NAME='squire'

# Squire loads libraries only once with require or require_relative.
# It checks LOADED_BY_SQUIRE array before issuing a load call.
#
# @todo Not implemented yet
LOADED_BY_SQUIRE=()

export SQUIRE_APPLICATION_NAME LOADED_BY_SQUIRE

# Conform to XDG specification
XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"

# Not standard, but should be
XDG_LOCAL_HOME="${HOME}/.local"
XDG_LIB_HOME="${XDG_LOCAL_HOME}/lib"
XDG_BIN_HOME="${XDG_LOCAL_HOME}/bin"

export XDG_DATA_HOME XDG_CONFIG_HOME XDG_CACHE_HOME XDG_LOCAL_HOME XDG_LIB_HOME XDG_BIN_HOME

# Sets the search path for installed libraries and loads
# necessary files to manage more dynamic requiring of
# libraries.
function setup_squire() {
  SQUIRE_PATH=$(readlink -m ${BASH_SOURCE%/*})
  SQUIRE_LIB_PATH=${SQUIRE_LIB_PATH:-$SQUIRE_PATH:${XDG_LIB_HOME}}

  source "${SQUIRE_PATH}/squire/load.sh"
  source "${SQUIRE_PATH}/squire/require.sh"

  export SQUIRE_LIB_PATH
}

setup_squire

require_relative $BASH_SOURCE 'squire/version'
require_relative $BASH_SOURCE 'squire/usage'
require_relative $BASH_SOURCE 'squire/utilities'
require_relative $BASH_SOURCE 'squire/configure'
squire_configure "$@"

require_relative $BASH_SOURCE 'squire/dependency_manager'
