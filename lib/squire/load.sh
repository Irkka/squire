function load() {
  library="${1}.sh"

  if [[ -f $library ]]; then
    source $library
    return 0
  fi

  return 1
}

export -f load
