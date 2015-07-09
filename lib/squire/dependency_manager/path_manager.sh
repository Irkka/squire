require_relative $BASH_SOURCE 'path_manager/awk'
require_relative $BASH_SOURCE 'path_manager/bin'
require_relative $BASH_SOURCE 'path_manager/lib'

function purge_squire_caches() {
  for cache in $SQUIRE_CACHE_BIN $SQUIRE_CACHE_LIB $SQUIRE_CACHE_AWK; do
    if [[ -d $cache ]]; then
      for item in $(ls $cache); do
        local cached_link="${cache}/${item}"
        if [[ -L $cached_link ]]; then
          echo "Removing ${cached_link} from squire cache."
          rm "${cached_link}"
        fi
      done
    fi
  done
}

# Processes all installed libraries and soft-links their executables and library modules to
# squire cache directories
#
# @param $1 [String] Directory path to where all external libraries reside
function integrate_external_libraries() {
  local library_directory=$1
  local libraries=$(ls $library_directory)

  # Remove symbolic links from cache directories
  echo 'Purging squire caches...'
  purge_squire_caches

  echo 'Populating cache paths...'
  for library in $libraries; do
    local library_path="${library_directory}/${library}"
    if [[ -d $library_path ]]; then
      process_external_library $library_path
    fi
  done
}

function process_external_library() {
  local library_path=$1

  process_bin_path $library_path
  process_lib_path $library_path
  process_awk_path $library_path
}

export -f process_external_library integrate_external_libraries purge_squire_caches
