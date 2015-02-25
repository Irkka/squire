SQUIRE_VERSION='0.0.1'

function version() {
  echo "${SQUIRE_APPLICATION_NAME} ${SQUIRE_VERSION}"
}

export -f version
export SQUIRE_VERSION
