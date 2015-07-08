# Clone git repo to the target dependency directory.
#
# @param $1 [String] The dependency directory where dependencies should be placed
# @param $2 [String] The git repository URL
function fetch_package() {
  local package_name=$1
  local package_url=$2

  git clone "${package_url}" "${SQUIRE_TEMP_DIR}/${package_name}"
}

function install_package() {
  local package_name=$1

  echo "Installing: ${package_name}"
  cp -ri "${SQUIRE_TEMP_DIR}/${package_name}" "${SQUIRE_EXTERNAL_LIBRARIES_DIR}/${package_name}"
}

export -f fetch_package install_package
