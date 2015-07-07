function process_missing_library() {
  required_library=$1

  echo "Library ${required_library} could not be found. Interrupting process: ${$}"

  # Ends current process without exiting the shell
  kill -INT $$

  #confirmation='Y'
  #read -t 10 -p 'Abort? (Y/n) ' confirmation

  #if [[ $confirmation =~ ^([Yy]|[Yy][Ee][Ss])$ ]]; then
    #exit 1
  #fi
}

export -f process_missing_library
