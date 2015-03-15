# Add dependency's library path to the SQUIRE_LIB_PATH
# global variable.
#
# @param $1 [String] The library path to append to SQUIRE_LIB_PATH
function append_library_path() {
  library_path=$1
  SQUIRE_LIB_PATH=${SQUIRE_LIB_PATH}:${library_path}

  export SQUIRE_LIB_PATH
}

# Add dependency's binary path to the PATH global
# variable.
#
# @param $1 [String] The binary path to append to PATH
function append_bin_path() {
  binary_path=$1
  PATH=${PATH}:${binary_path}

  export PATH
}

function build_external_library_path() {
  library_directory=$1
  libraries=$(ls $library_directory)

  for library in $libraries; do
    library_path="${library_directory}/${library}"
    if [[ -d $library_path ]]; then
      process_external_library $library_path
    fi
  done
}

function process_external_library() {
  library_path=$1

  process_bin_path $library_path
  process_lib_path $library_path
  process_awk_path $library_path
}

function process_bin_path() {
  library_path=$1
  # Convention over configuration for now
  library_bin_path="${library_path}/bin"

  library_binaries=$(ls $library_bin_path)
  for binary in $library_binaries; do
    binary_path="${library_bin_path}/${binary}"
    if [[ -x $binary_path ]]; then
      ln -sf $binary_path "${SQUIRE_CACHE_BIN}/$binary"
    fi
  done
}

function process_lib_path() {
  library_path=$1
  # Convention over configuration for now
  library_lib_path="${library_path}/lib"

  if [[ -d $library_lib_path ]]; then
    append_library_path $library_lib_path
  fi
}

function process_awk_path() {
  library_path=$1

  # Find all directories containing awk source files
  awk_files=$(find $library_path -type f -name '*.awk')

  for awk_file in $awk_files; do
    ln -sf $awk_file "${SQUIRE_CACHE_AWKPATH}/${awk_file##*/}"
  done
}

export -f append_bin_path append_library_path build_external_library_path process_external_library process_lib_path process_bin_path process_awk_path
