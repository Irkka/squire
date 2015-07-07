#                                      
#  ####   ####  #    # # #####  ###### 
# #      #    # #    # # #    # #      
#  ####  #    # #    # # #    # #####  
#      # #  # # #    # # #####  #      
# #    # #   #  #    # # #   #  #      
#  ####   ### #  ####  # #    # ###### 
#                                      

PREFIX ?= ~/.local

binary_path = $(shell readlink -m './bin')
binaries = $(shell ls $(binary_path))
library_path = $(shell readlink -m './lib')
libraries = $(shell ls $(library_path))

default: usage
usage:
	@echo 'Usage:'
	@echo 'make <install|uninstall|reinstall|build-documentation>'
reinstall: uninstall install
install:
	@echo 'Installing binaries'
	@for binary in $(binaries); do \
		echo $$binary; \
		mkdir -p $(PREFIX)/bin; \
		cp $(binary_path)/$$binary $(PREFIX)/bin/$$binary; \
	done
	@echo 'Installing libraries'
	@for library in $(libraries); do \
		echo $$library; \
		mkdir -p $(PREFIX)/lib; \
		cp -r $(library_path)/$$library $(PREFIX)/lib/$$library; \
	done
uninstall:
	@echo 'Uninstalling binaries'
	@for binary in $(binaries); do \
		echo $$binary; \
		rm $(PREFIX)/bin/$$binary; \
	done
	@echo 'Uninstalling libraries'
	@for library in $(libraries); do \
		echo $$library; \
		rm -r $(PREFIX)/lib/$$library; \
	done
build-documentation:
	echo 'To be implemented'
