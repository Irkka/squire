function process_lib_path() {
  library_path=$1
  # Convention over configuration for now
  library_lib_path="${library_path}/lib"

  if [[ -d $library_lib_path ]]; then
    library_libraries=$(ls $library_lib_path)
    for library in $library_libraries; do
      library_path="${library_lib_path}/${library}"
      library_target_path="${SQUIRE_CACHE_LIB}/$library"
      if [[ -f $library_path && ! -e $library_target_path ]]; then
        ln -s $library_path $library_target_path
      else
        # Can't tolerate overwriting libraries - maybe a better solution can be found later
        echo "Target library ${library_target_path} already exists. Exiting."
        kill -INT $$
      fi
    done
  fi
}

export -f process_lib_path
