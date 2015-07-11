require_relative '../../squire.sh'
require_relative 'cli/usage'

function squire_exec() {
  local command=$1

  # Find the library folder of the current project. AWKPATH will be more of a challenge
  SQUIRE_LIB_PATH="${PWD}/lib:${SQUIRE_LIB_PATH}"
  export SQUIRE_LIB_PATH

  eval $command
}

function squire_install() {
  dispatch_packages "$@"
}

function parse_cli_install_options() {
  local options=$(getopt -qu -o 'hg' --long 'help,global' -- "$@")
  set -- $options
  echo $@

  while [[ -n "$1" ]]; do
    case "$1" in
      -h|--help )
        shift
        squire_usage
        exit 1
        ;;
      -g|--global )
        shift
        echo 'global activated'
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

  echo $options
}

function parse_cli_command() {
  while [[ -n "$1" ]]; do
    case "$1" in
      -v|--version )
        squire_version
        exit 0
        ;;
      -h|--help )
        squire_usage
        exit 1
        ;;
      init )
        cat <<INIT
          squire_locations="\${HOME}/.local/lib /usr/lib"
          echo \$squire_locations
INIT
        shift
        exit 0
        ;;
      exec )
        shift
        squire_exec "$@"
        exit 0
        ;;
      install )
        shift
        squire_install "$@"
        exit 0
        ;;
      uninstall )
        shift
        echo $@
        exit 0
        ;;
      * )
        break
        ;;
    esac
  done

  squire_usage
  exit 1
}

export -f parse_cli_command parse_cli_install_options squire_install squire_exec
