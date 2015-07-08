# Conform to the XDG specification
function set_xdg_variables() {
  XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
  XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
  XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"

  # Not standard, but should be
  XDG_LOCAL_HOME="${HOME}/.local"
  XDG_LIB_HOME="${XDG_LOCAL_HOME}/lib"
  XDG_BIN_HOME="${XDG_LOCAL_HOME}/bin"

  export XDG_DATA_HOME XDG_CONFIG_HOME XDG_CACHE_HOME XDG_LOCAL_HOME XDG_LIB_HOME XDG_BIN_HOME
}

function set_squire_variables() {
  SQUIRE_CONFIG=${SQUIRE_CONFIG:-${XDG_CONFIG_HOME}/${SQUIRE_APPLICATION_NAME}}
  SQUIRE_DATA=${SQUIRE_DATA:-${XDG_DATA_HOME}/${SQUIRE_APPLICATION_NAME}}
  SQUIRE_CACHE=${SQUIRE_CACHE:-${XDG_CACHE_HOME}/${SQUIRE_APPLICATION_NAME}}
  SQUIRE_CACHE_BIN="${SQUIRE_CACHE}/bin"
  SQUIRE_CACHE_LIB="${SQUIRE_CACHE}/lib"
  SQUIRE_CACHE_AWK="${SQUIRE_CACHE}/awk"
  SQUIRE_EXTERNAL_LIBRARIES_DIR="${SQUIRE_EXTERNAL_LIBRARIES_DIR:-${SQUIRE_CACHE}/external}"

  # SQUIRE_TEMP_DIR is generated automatically under $SQUIRE_TEMP_DIR_ROOT at bootstrap phase, and thus it can't be configured here
  local temp_dir=${TEMP_DIR:-/tmp}
  SQUIRE_TEMP_DIR_ROOT=${SQUIRE_TEMP_DIR_ROOT:-${temp_dir}/${SQUIRE_APPLICATION_NAME}}

  export SQUIRE_CONFIG SQUIRE_DATA SQUIRE_CACHE SQUIRE_CACHE_BIN SQUIRE_CACHE_LIB SQUIRE_EXTERNAL_LIBRARIES_DIR SQUIRE_TEMP_DIR_ROOT
}

function set_system_path_variables() {
  PATH="${PATH}:${SQUIRE_CACHE_BIN}"
  # This is the primary search path for modules
  SQUIRE_LIB_PATH="${SQUIRE_LIB_PATH}:${SQUIRE_CACHE_LIB}"

  if [[ -z $AWKPATH ]]; then
    AWKPATH="${SQUIRE_CACHE_AWK}"
  else
    AWKPATH="${AWKPATH}:${SQUIRE_CACHE_AWK}"
  fi

  export PATH AWKPATH
}

function squire_configure() {
  set_xdg_variables
  set_squire_variables
  set_system_path_variables
}
