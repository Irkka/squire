function process_missing_library() {
  local required_library=$1

  echo "Library ${required_library} could not be found. Interrupting process: ${$}"

  # Ends current process without exiting the shell
  kill -INT $$
}

export -f process_missing_library
