function process_awk_path() {
  local library_path=$1
  # Convention over configuration for now
  local library_awk_path="${library_path}/lib"

  # Find all directories containing awk source files
  local awk_files=$(find $library_awk_path -type f -name '*.awk')

  for awk_file in $awk_files; do
    local awk_file_namespaced_name=${awk_file#${library_awk_path}/}
    # Make directory paths dashes - awk doesn't support loading from directories under AWKPATH
    local target_awk_file=${awk_file_namespaced_name//\//-}
    local awk_target_path="${SQUIRE_CACHE_AWK}/${target_awk_file}"

    if [[ -f $awk_file && ! -e $awk_target_path ]]; then
      ln -s $awk_file $awk_target_path
    else
      # Can't tolerate overwriting awk libraries - maybe a better solution can be found later
      echo "Target awk library ${awk_target_path} already exists. Exiting."
      kill -INT $$
    fi
  done
}

export -f process_awk_path
