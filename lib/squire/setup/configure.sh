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
  SQUIRE_GLOBAL_LIBRARIES_DIR="${SQUIRE_GLOBAL_LIBRARIES_DIR:-${SQUIRE_CACHE}/external}"

  export SQUIRE_CONFIG SQUIRE_DATA SQUIRE_CACHE SQUIRE_CACHE_BIN SQUIRE_CACHE_LIB SQUIRE_GLOBAL_LIBRARIES_DIR
}

function set_system_path_variables() {
  PATH="${PATH}:${SQUIRE_CACHE_BIN}"

  if [[ ! -v AWKPATH ]]; then
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
