# Sources the given library.
#
# @example Source a file
#   #!/bin/bash
#   load 'example'
# @param $1 [String] The library to be loaded
function load() {
  library="${1}.sh"

  if [[ -f $library ]]; then
    source $library
    return 0
  fi

  return 1
}

export -f load
