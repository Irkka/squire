require_relative $BASH_SOURCE 'dispatcher/installer'

function extract_name() {
  package_handle=$1

  echo "${package_handle##*/}"
}

function extrapolate_url() {
  package_handle=$1

  echo "https://github.com/${package_handle}.git"
}

function dispatch_packages() {
  local packages=$1

  # Create temporary storage under $SQUIRE_TEMP_DIR_ROOT
  create_squire_temp_directory $SQUIRE_TEMP_DIR_ROOT

  for package in $packages; do
    local package_name=$(extract_name $package)
    # Use github url by default for now
    local package_url=$(extrapolate_url $package)

    fetch_package $package_name $package_url
    install_package $package_name
  done

  echo 'Rebuilding squire caches...'
  integrate_external_libraries $SQUIRE_EXTERNAL_LIBRARIES_DIR
}

# Parses the project Squirefile and sends each of them to be
# processed.
#
# @param $0 [String] Path to the executable that initiated dependency manager
#function dispatch_dependencies() {
  #local executable_path=${0%/*}

  #local squirefile=$(reverse_find $(readlink -m $executable_path) 'Squirefile')
  #local squirefile_path=${squirefile%/*}

  #local squire_dependency_directory="${squirefile_path}/squire_dependencies"
  #[[ ! -d $squire_dependency_directory ]] && mkdir $squire_dependency_directory

  #cat $squirefile|parallel --no-notice process_dependency $squire_dependency_directory {}
#}

export -f extract_name extrapolate_url dispatch_packages
