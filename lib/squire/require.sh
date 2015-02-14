function require() {
  library_directories=$(echo $BASHLIBPATH|tr ':', ' ')
  for library_directory in $library_directories ; do
    library=$(readlink -m "${library_directory%%\/}/${1%%\.*}.sh")
    if [[ -f $library ]]; then
      source $library
      break
    fi
  done
}

function require_relative() {
  library=$(readlink -f "${BASH_SOURCE}/${1##\/%%\.*}.sh")
  echo $library
}

export -f require require_relative
