# Parses the project Squirefile and sends each of them to be
# processed.
#
# @param $0 [String] Path to the executable that initiated dependency manager
function dispatch_dependencies() {
  local executable_path=${0%/*}

  local squirefile=$(reverse_find $(readlink -m $executable_path) 'Squirefile')
  local squirefile_path=${squirefile%/*}

  local squire_dependency_directory="${squirefile_path}/squire_dependencies"
  [[ ! -d $squire_dependency_directory ]] && mkdir $squire_dependency_directory

  cat $squirefile|parallel --no-notice process_dependency $squire_dependency_directory {}
}

# Process the given resource identifier
#
# @param $1 [String] The dependency directory where dependencies should be placed
# @param $2 [String] The dependency identifier
function process_dependency() {
  local squire_dependency_directory="$1"
  local squire_dependency="$2"

  fetch_dependency $squire_dependency_directory $squire_dependency
}

# Clone git repo to the target dependency directory.
#
# @param $1 [String] The dependency directory where dependencies should be placed
# @param $2 [String] The git repository URL
function fetch_dependency() {
  local squire_dependency_directory="$1"
  local squire_dependency="$2"

  git clone $squire_dependency ${squire_dependency_directory}/${squire_dependency##*/}
}

export -f dispatch_dependencies process_dependency fetch_dependency
