require_relative $BASH_SOURCE 'path_manager/awk'
require_relative $BASH_SOURCE 'path_manager/bin'
require_relative $BASH_SOURCE 'path_manager/lib'

# Processes all installed libraries and soft-links their executables and library modules to
# squire cache directories
#
# @param $1 [String] Directory path to where all external libraries reside
function integrate_external_libraries() {
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

export -f process_external_library integrate_external_libraries
