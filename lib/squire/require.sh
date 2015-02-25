function require() {
  required_library=$1
  library_directories=$(echo $BASHLIB_PATH|tr ':', ' ')

  for library_directory in $library_directories ; do
    library=$(readlink -f "${library_directory%%\/}/${required_library%%\.*}")
    if load $library ; then
      return 0
    fi
  done

  echo "Library $required_library could not be found"
  exit 1
}

# At the moment $BASH_SOURCE needs to be passed to require_relative
# but preferably this functionality should be incorporated to the
# function itself – no clue how to achieve this yet, though
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
