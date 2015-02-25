function dispatch_dependencies() {
  executable_path=${0%/*}

  squirefile=$(reverse_find $(readlink -m $executable_path) 'Squirefile')
  squirefile_path=${squirefile%/*}

  squire_dependency_directory="${squirefile_path}/squire_dependencies"
  [[ ! -d $squire_dependency_directory ]] && mkdir $squire_dependency_directory

  cat $squirefile|parallel --no-notice process_dependency $squire_dependency_directory {}
}

function process_dependency() {
  squire_dependency_directory="$1"
  squire_dependency="$2"

  fetch_dependency $squire_dependency_directory $squire_dependency
}

function fetch_dependency() {
  squire_dependency_directory="$1"
  squire_dependency="$2"

  git clone $squire_dependency ${squire_dependency_directory}/${squire_dependency##*/}
}

function append_library_path() {
  library_path=$1
  BASHLIB_PATH=${BASHLIB_PATH}:${library_path}

  export BASHLIB_PATH
}

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

export -f fetch_dependency reverse_find append_library_path dispatch_dependencies process_dependency
