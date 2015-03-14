# Searches for the given library from each path declared in
# SQUIRE_LIB_PATH global variable. If the library is not found,
# require will exit the script with a failure.
#
# @example Require a library relative to each entry in SQUIRE_LIB_PATH
#   #!/bin/bash
#   require 'example'
# @param $1 [String] the library to be searched for
function require() {
  required_library=$1
  library_directories=$(echo $SQUIRE_LIB_PATH|tr ':', ' ')

  for library_directory in $library_directories ; do
    library=$(readlink -f "${library_directory%%\/}/${required_library%%\.*}")
    if load $library ; then
      return 0
    fi
  done

  echo "Library $required_library could not be found"
  exit 1
}

# Searches for the given library relative to the path of the
# current file. If the library is not found, require will
# exit the script with a failure.
#
# @todo At the moment $BASH_SOURCE needs to be passed to require_relative
#   but preferably this functionality should be incorporated to the
#   function itself – no clue how to achieve this yet, though.
# @example Require a project library relative to the executable
#   #!/bin/bash
#   require_relative $BASH_SOURCE '../lib/example'
# @param $1 [String] Full path to the current file
# @param $2 [String] Required library's path relative to the calling script
function require_relative() {
  if [[ -d $1 ]]; then
    relative_root_directory="$1"
  else
    relative_root_directory="${1%/*}"
  fi
  required_library_relative_path="${2}"

  library=$(readlink -f "${relative_root_directory}/${required_library_relative_path}")
  if load "${library}"; then
    return 0
  fi

  echo "Library $library could not be found"
  exit 1
}

export -f require require_relative
