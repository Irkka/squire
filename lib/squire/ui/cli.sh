require_relative $BASH_SOURCE 'cli/usage'

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
