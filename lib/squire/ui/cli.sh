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
