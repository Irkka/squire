# Create directories if they don't exist
#
# @param $1 [Array<String>] Directory paths to create
function create_directories() {
  directories="$@"
  for directory in $directories; do
    if [[ ! -d $directory ]]; then
      echo "Creating inexistent $directory"
      mkdir -p $directory
    fi
  done
}

export -f create_directories
