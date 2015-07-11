#!/bin/bash
# @author Ilkka Hakkarainen <ilkka.hakkarainen@cs.helsinki.fi>

# Sets the search path for installed libraries and loads
# necessary files to manage more dynamic requiring of
# libraries.
function enable_require() {
  local squire_entry_point=$(readlink -m $BASH_SOURCE)
  local squire_base="squire/base"

  SQUIRE_LIB_PATH=${squire_entry_point%/*}

  source "${SQUIRE_LIB_PATH}/${squire_base}/process_missing_library.sh"
  source "${SQUIRE_LIB_PATH}/${squire_base}/load.sh"
  source "${SQUIRE_LIB_PATH}/${squire_base}/require.sh"
  source "${SQUIRE_LIB_PATH}/${squire_base}/require_relative.sh"

  LOADED_BY_SQUIRE=$squire_entry_point

  export SQUIRE_LIB_PATH LOADED_BY_SQUIRE
}

# Enable load, require and require_relative functionality
enable_require

require_relative 'squire/meta'
require_relative 'squire/setup'
