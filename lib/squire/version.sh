# The authoritative version number of this library.
SQUIRE_VERSION='0.0.1'

# Print out the library name and version to stdout.
function version() {
  echo "${SQUIRE_APPLICATION_NAME} ${SQUIRE_VERSION}"
}

export -f version
export SQUIRE_VERSION
