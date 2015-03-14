# Search for a search item backwards in directory structure.
#
# @param $1 [String] The starting directory for the search
# @param $2 [String] The search item
function reverse_find() {
  directory=$(readlink -m $1)
  search_item=$2

  while [[ -n $directory ]]; do
    item="${directory}/${search_item}"
    if [[ -e "$item" ]]; then
      echo $item
      return 0
    fi

    directory=${directory%/*}
  done

  echo "${search_item} not found."
  return 1
}

function create_directories() {
  directories="$@"
  for directory in $directories; do
    if [[ ! -d $directory ]]; then
      echo "Creating inexistent $directory"
      mkdir -p $directory
    fi
  done
}

# Add dependency's library path to the SQUIRE_LIB_PATH
# global variable.
#
# @param $1 [String] The library path to append to SQUIRE_LIB_PATH
function append_library_path() {
  library_path=$1
  SQUIRE_LIB_PATH=${SQUIRE_LIB_PATH}:${library_path}

  export SQUIRE_LIB_PATH
}

# Add dependency's binary path to the PATH global
# variable.
#
# @param $1 [String] The binary path to append to PATH
function append_bin_path() {
  binary_path=$1
  PATH=${PATH}:${binary_path}

  export PATH
}

export -f reverse_find append_library_path
