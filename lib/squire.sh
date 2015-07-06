#!/bin/bash
# @author Ilkka Hakkarainen <ilkka.hakkarainen@cs.helsinki.fi>

# Sets the search path for installed libraries and loads
# necessary files to manage more dynamic requiring of
# libraries.
function enable_require() {
  SQUIRE_ENTRY_POINT=$(readlink -m $BASH_SOURCE)
  SQUIRE_PATH=${SQUIRE_ENTRY_POINT%/*}
  SQUIRE_LIB_PATH=${SQUIRE_LIB_PATH:-$SQUIRE_PATH}

  SQUIRE_BASE="squire/base"

  source "${SQUIRE_PATH}/${SQUIRE_BASE}/process_missing_library.sh"
  source "${SQUIRE_PATH}/${SQUIRE_BASE}/load.sh"
  source "${SQUIRE_PATH}/${SQUIRE_BASE}/require.sh"
  source "${SQUIRE_PATH}/${SQUIRE_BASE}/require_relative.sh"

  # Squire loads libraries only once with load.
  # It checks LOADED_BY_SQUIRE array before issuing a source call.
  # Maybe this could be forced in the future?
  #
  # @todo Not implemented yet
  LOADED_BY_SQUIRE=()

  export SQUIRE_PATH SQUIRE_LIB_PATH LOADED_BY_SQUIRE
}

# Enable require and require_relative functionality
enable_require

require_relative $BASH_SOURCE 'squire/meta'
require_relative $BASH_SOURCE 'squire/setup'

squire_setup "$@"
