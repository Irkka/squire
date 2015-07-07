function process_bin_path() {
  local library_path=$1
  # Convention over configuration for now
  local library_bin_path="${library_path}/bin"

  if [[ -d $library_bin_path ]]; then
    local library_binaries=$(ls $library_bin_path)
    for binary in $library_binaries; do
      local binary_path="${library_bin_path}/${binary}"
      local binary_target_path="${SQUIRE_CACHE_BIN}/$binary"
      if [[ -x $binary_path && ! -e $binary_target_path ]]; then
        ln -s $binary_path $binary_target_path
      else
        # Can't tolerate overwriting binaries - maybe a better solution can be found later
        echo "Binary ${binary} already exists. Exiting."
        kill -INT $$
      fi
    done
  fi
}

export -f process_bin_path
