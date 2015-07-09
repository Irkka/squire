# Sources the given library.
#
# @example Source a file
#   #!/bin/bash
#   load 'example'
# @param $1 [String] The library to be loaded
function load() {
  local library="${1}"

  if [[ -f $library ]]; then
    for loaded_library in ${LOADED_BY_SQUIRE}; do
      if [[ $library = $loaded_library ]]; then
        echo "Library $library already loaded. Ignoring."
        return 0
      fi
    done

    source $library
    LOADED_BY_SQUIRE="${LOADED_BY_SQUIRE} ${library}"
    export LOADED_BY_SQUIRE

    echo "${library} loaded"
    return 0
  fi

  echo "Library not found here: ${library}"
  return 1
}

export -f load
