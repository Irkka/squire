SQUIRE_REQUIRE_RELATIVE_CALL_STACK=''

function search_string_from_caller_file_source() {
  local caller=$1
  local required_library_relative_path_string=$2

  if grep "require_relative '${required_library_relative_path_string}'" $caller > /dev/null; then
    return 0
  fi

  return 1
}

function search_string_from_stack() {
  local required_library_relative_path_string=$1
  local call_stack=$SQUIRE_REQUIRE_RELATIVE_CALL_STACK

  for caller in $call_stack; do
    if search_string_from_caller_file_source $caller $required_library_relative_path_string ; then
      echo $caller
      return 0
    else
      # pop global call stack
      SQUIRE_REQUIRE_RELATIVE_CALL_STACK=${SQUIRE_REQUIRE_RELATIVE_CALL_STACK#* }
      export SQUIRE_REQUIRE_RELATIVE_CALL_STACK
    fi
  done

  echo "No caller file was found: ${required_library_relative_path}. Exiting."
  kill -INT $$
}

# Searches for the given library relative to the path of the
# current file. If the library is not found, require will
# exit the script with a failure.
#
# @example Require a project library relative to the calling script
#   #!/bin/bash
#   require_relative 'directory/subdirectory/library'
# @param $1 [String] Full path to the current file
# @param $2 [String] Required library's path relative to the calling script
function require_relative() {
  local required_library_relative_path="${1}"
  # calling script
  local caller=$(caller|awk -F ' ' '{ print $2 }')

  if [[ -z $caller || $caller = 'NULL' ]]; then
    #search_string_from_stack $required_library_relative_path
    caller="$(search_string_from_stack $required_library_relative_path)"
  else
    # push new source file path to call stack
    SQUIRE_REQUIRE_RELATIVE_CALL_STACK="$caller ${SQUIRE_REQUIRE_RELATIVE_CALL_STACK}"
    export SQUIRE_REQUIRE_RELATIVE_CALL_STACK
  fi

  local absolute_root_directory=${caller%\/*}

  local library_path="${absolute_root_directory}/${required_library_relative_path%\.sh}.sh"
  ## Resolve .., ., and other special characters in the path
  local library=$(readlink -m ${library_path})

  if load $library ; then
    return 0
  fi

  process_missing_library $library
  return 1
}

export SQUIRE_REQUIRE_RELATIVE_CALL_STACK
export -f require_relative search_string_from_stack search_string_from_caller_file_source
