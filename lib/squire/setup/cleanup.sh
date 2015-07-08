function unset_xdg_variables() {
  unset XDG_DATA_HOME XDG_CONFIG_HOME XDG_CACHE_HOME XDG_LOCAL_HOME XDG_LIB_HOME XDG_BIN_HOME
}

function unset_squire_variables() {
  unset SQUIRE_CONFIG SQUIRE_DATA SQUIRE_CACHE SQUIRE_CACHE_BIN SQUIRE_CACHE_LIB SQUIRE_GLOBAL_LIBRARIES_DIR
  # These can't be unset here, because they're already defined - cleanup altogether should be located elsewhere
  #unset SQUIRE_APPLICATION_NAME SQUIRE_BASE SQUIRE_CACHE_AWKPATH SQUIRE_ENTRY_POINT SQUIRE_LIB_PATH SQUIRE_VERSION
}

function remove_directory_from_path_variable() {
  local path_variable_name=$1
  local path_to_remove=$2

  # evaluate the cleanup routine here
}

function clean_system_path_variables() {
  # Surround each directory with colons, delete each SQUIRE_CACHE_BIN instance and replace with a colon, delete surrounding colons
  PATH=":${PATH}:"
  PATH="${PATH//:$SQUIRE_CACHE_BIN:/:}"
  PATH="${PATH#:}"
  PATH="${PATH%:}"

  AWKPATH=":${AWKPATH}:"
  AWKPATH="${AWKPATH//:$SQUIRE_CACHE_AWK:/:}"
  AWKPATH="${AWKPATH#:}"
  AWKPATH="${AWKPATH%:}"

  export PATH AWKPATH
}

# Necessary, but its position should be changed.
# List of functions to unset should be generated too.
function unset_squire_functions() {
  unset -f squire_bootstrap squire_cleanup squire_configure squire_setup squire_usage squire_version require require_relative load process_missing_library
}

# Unset all function and variable declarations set by squire.
# squire_cleanup should remove squire-managed scripts from PATH and AWKPATH.
function squire_cleanup() {
  clean_system_path_variables
  unset_squire_variables
  unset_xdg_variables
}
