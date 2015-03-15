function squire_configure() {
  SQUIRE_CONFIG=${SQUIRE_CONFIG:-${XDG_CONFIG_HOME}/${SQUIRE_APPLICATION_NAME}}
  SQUIRE_DATA=${SQUIRE_DATA:-${XDG_DATA_HOME}/${SQUIRE_APPLICATION_NAME}}
  SQUIRE_CACHE=${SQUIRE_CACHE:-${XDG_CACHE_HOME}/${SQUIRE_APPLICATION_NAME}}
  SQUIRE_CACHE_BIN="${SQUIRE_CACHE}/bin"
  SQUIRE_CACHE_LIB="${SQUIRE_CACHE}/lib"
  SQUIRE_CACHE_AWKPATH="${SQUIRE_CACHE}/awk"
  SQUIRE_GLOBAL_LIBRARIES_DIR="${SQUIRE_GLOBAL_LIBRARIES_DIR:-${SQUIRE_CACHE}/external}"

  create_directories $SQUIRE_CONFIG $SQUIRE_DATA $SQUIRE_CACHE $SQUIRE_CACHE_BIN $SQUIRE_CACHE_LIB $SQUIRE_CACHE_AWKPATH $SQUIRE_GLOBAL_LIBRARIES_DIR

  PATH="${PATH}:${SQUIRE_CACHE_BIN}"
  if [[ ! -v AWKPATH ]]; then
    AWKPATH="${SQUIRE_CACHE_AWKPATH}"
  else
    AWKPATH="${AWKPATH}:${SQUIRE_CACHE_AWKPATH}"
  fi

  export SQUIRE_CONFIG SQUIRE_DATA SQUIRE_CACHE SQUIRE_CACHE_BIN SQUIRE_CACHE_LIB SQUIRE_GLOBAL_LIBRARIES_DIR PATH AWKPATH

  build_external_library_path $SQUIRE_GLOBAL_LIBRARIES_DIR
}

function parse_cli_command() {
  command=$1
  shift

  parse_cli_command_options "$@"
}

function parse_cli_command_options() {
  options=$(getopt -qu -o 'g' -l 'global' -- "$@")
  set -- $options

  while [[ -n "$1" ]]; do
    case "$1" in
      -g|--global )
        $SQUIRE_EXTERNAL_LIBRARY_PATH=${XDG_SQUIRE_DATA}/external_libraries
        shift
        ;;
      -- )
        shift
        break
        ;;
      * )
        echo 'Invalid switch.'
        exit 1
        ;;
    esac
  done
}

function parse_cli_options() {
options=$(getopt -qu -o 'h?v' -l 'help,version' -- "$@")
set -- $options

while [[ -n "$1" ]]; do
  case "$1" in
    -v|--version )
      version
      exit 0
      ;;
    -h|--help )
      usage
      ;;
    -- )
      shift
      break
      ;;
    * )
      echo 'Internal error.'
      exit 1
      ;;
  esac
done
}
