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

export -f reverse_find create_directories
