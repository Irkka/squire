# Create directories if they don't exist
#
# @param $1 [Array<String>] Directory paths to create
function create_directories() {
  local directories="$@"
  for directory in $directories; do
    if [[ ! -d $directory ]]; then
      echo "Creating inexistent $directory"
      mkdir -p $directory
    fi
  done
}

function create_squire_temp_directory() {
  echo "Creating squire temporary directory root, if it doesn't exist: ${SQUIRE_TEMP_DIR_ROOT}"
  mkdir -p $SQUIRE_TEMP_DIR_ROOT

  SQUIRE_TEMP_DIR=$(mktemp -d -p $SQUIRE_TEMP_DIR_ROOT $(date +%F)-XXXXXXXX)
  echo "Created: ${SQUIRE_TEMP_DIR}"
  export SQUIRE_TEMP_DIR
}

export -f create_directories create_squire_temp_directory
