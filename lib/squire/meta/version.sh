require_relative 'application_name'

# The authoritative version number of this library.
SQUIRE_VERSION='0.0.1'

# Print out the library name and version to stdout.
function squire_version() {
  echo "${SQUIRE_APPLICATION_NAME} ${SQUIRE_VERSION}"
}

export SQUIRE_VERSION
export -f squire_version
