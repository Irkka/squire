# Parses the project Squirefile and sends each of them to be
# processed.
#
# @param $0 [String] Path to the executable that initiated dependency manager
function dispatch_dependencies() {
  executable_path=${0%/*}

  squirefile=$(reverse_find $(readlink -m $executable_path) 'Squirefile')
  squirefile_path=${squirefile%/*}

  squire_dependency_directory="${squirefile_path}/squire_dependencies"
  [[ ! -d $squire_dependency_directory ]] && mkdir $squire_dependency_directory

  cat $squirefile|parallel --no-notice process_dependency $squire_dependency_directory {}
}

# Process the given resource identifier
#
# @param $1 [String] The dependency directory where dependencies should be placed
# @param $2 [String] The dependency identifier
function process_dependency() {
  squire_dependency_directory="$1"
  squire_dependency="$2"

  fetch_dependency $squire_dependency_directory $squire_dependency
}

# Clone git repo to the target dependency directory.
#
# @param $1 [String] The dependency directory where dependencies should be placed
# @param $2 [String] The git repository URL
function fetch_dependency() {
  squire_dependency_directory="$1"
  squire_dependency="$2"

  git clone $squire_dependency ${squire_dependency_directory}/${squire_dependency##*/}
}

export -f fetch_dependency dispatch_dependencies process_dependency
