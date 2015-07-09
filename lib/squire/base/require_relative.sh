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
  local absolute_bash_source=$(readlink -m $1)
  local required_library_relative_path="${2}"
  local absolute_root_directory="${absolute_bash_source%\/*}"
  # Force .sh suffix
  local library_path="${absolute_root_directory}/${required_library_relative_path%\.sh}.sh"

  # Resolve .., ., and other special characters in the path
  local library=$(readlink -m ${library_relative_path})
  if load $library ; then
    return 0
  fi

  process_missing_library $library
  return 1
}

export -f require_relative
