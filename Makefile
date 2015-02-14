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
	echo 'Hello'
reinstall: uninstall install
install:
	@echo 'Installing executables'
	@for binary in $(binaries); do \
		echo $$binary \
		cp $(binary_path)/$$binary $(PREFIX)/bin/$$binary; \
	done
	@echo 'Installing libraries'
	@for library in $(libraries); do \
		echo $$library \
		cp -r $(library_path)/$$library $(PREFIX)/lib/$$library; \
	done
uninstall:
	@echo 'Uninstalling executables'
	@for binary in $(binaries); do \
		echo $$binary \
		rm $(PREFIX)/bin/$$binary; \
	done
	@echo 'Uninstalling libraries'
	@for library in $(libraries); do \
		echo $$library \
		rm -r $(library_path)/$$library $(PREFIX)/lib/$$library; \
	done
build-documentation:
	# bashdoc
