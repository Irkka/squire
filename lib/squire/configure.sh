function squire_configure() {
  SQUIRE_CONFIG=${SQUIRE_CONFIG:-${XDG_CONFIG_HOME}/${SQUIRE_APPLICATION_NAME}}
  SQUIRE_DATA=${SQUIRE_DATA:-${XDG_DATA_HOME}/${SQUIRE_APPLICATION_NAME}}
  SQUIRE_CACHE=${SQUIRE_CACHE:-${XDG_CACHE_HOME}/${SQUIRE_APPLICATION_NAME}}
  SQUIRE_GLOBAL_LIBRARIES_DIR="${SQUIRE_GLOBAL_LIBRARIES_DIR:-${SQUIRE_CACHE}/external}"

  create_directories $SQUIRE_CONFIG $SQUIRE_DATA $SQUIRE_CACHE $SQUIRE_GLOBAL_LIBRARIES_DIR
  export SQUIRE_CONFIG SQUIRE_DATA SQUIRE_CACHE SQUIRE_GLOBAL_LIBRARIES_DIR

  build_external_library_path $SQUIRE_GLOBAL_LIBRARIES_DIR
}

function build_external_library_path() {
  library_directory=$1
  libraries=$(ls -1 $library_directory|xargs)

  for library in $libraries; do
    library_path="${library_directory}/${library}"
    if [[ -d $library_path ]]; then
      process_external_library $library_path
    fi
  done
  # This should be managed when running squire within projects not at bootstrapping time
  #SQUIRE_DEPENDENCIES_DIR=${SQUIRE_DEPENDENCIES_DIR:-$(readlink -m $(dirname $(reverse_find ${BASH_SOURCE%/*} 'Squirefile')))/squire_dependencies}
}

function process_external_library() {
  external_library_path=$1

  process_bin_path $external_library_path
  process_lib_path $external_library_path
}

function process_bin_path() {
  external_library_path=$1
  # Convention over configuration for now
  external_library_bin_path="${external_library_path}/bin"

  if [[ -d $external_library_bin_path ]]; then
    append_bin_path $external_library_bin_path
  fi
}

function process_lib_path() {
  external_library_path=$1
  # Convention over configuration for now
  external_library_lib_path="${external_library_path}/lib"

  if [[ -d $external_library_lib_path ]]; then
    append_library_path $external_library_lib_path
  fi
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
