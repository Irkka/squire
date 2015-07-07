# Searches for the given library from each path declared in
# SQUIRE_LIB_PATH global variable. If the library is not found,
# require will exit the script with a failure.
#
# @example Require a library relative to each entry in SQUIRE_LIB_PATH
#   #!/bin/bash
#   require 'example'
# @param $1 [String] the library to be searched for
function require() {
  local required_library=$1
  local library_directories=$(echo $SQUIRE_LIB_PATH|tr ':', ' ')

  for library_directory in $library_directories ; do
    local library=$(readlink -f "${library_directory%%\/}/${required_library%%\.*}")
    if load $library ; then
      return 0
    fi
  done

  process_missing_library $required_library
  return 1
}

export -f require
