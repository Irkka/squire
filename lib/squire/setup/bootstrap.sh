require_relative '../utilities'
require_relative '../dependency_manager'

function squire_bootstrap() {
  create_directories $SQUIRE_CONFIG $SQUIRE_DATA $SQUIRE_CACHE $SQUIRE_CACHE_BIN $SQUIRE_CACHE_LIB $SQUIRE_CACHE_AWKPATH $SQUIRE_EXTERNAL_LIBRARIES_DIR
  integrate_external_libraries $SQUIRE_EXTERNAL_LIBRARIES_DIR
}
