function process_awk_path() {
  local library_path=$1

  # Find all directories containing awk source files
  local awk_files=$(find $library_path -type f -name '*.awk')

  for awk_file in $awk_files; do
    local target_awk_file_namespaced_name=${awk_file#./}
    local target_awk_file_namespaced_name=${awk_file//\//-}
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
