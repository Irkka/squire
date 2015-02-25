#                                      
#  ####   ####  #    # # #####  ###### 
# #      #    # #    # # #    # #      
#  ####  #    # #    # # #    # #####  
#      # #  # # #    # # #####  #      
# #    # #   #  #    # # #   #  #      
#  ####   ### #  ####  # #    # ###### 
#                                      

PREFIX ?= ~/.local

library_path = $(shell readlink -m './lib')
libraries = $(shell ls $(library_path))

default: usage
usage:
	echo 'Hello'
reinstall: uninstall install
install:
	@echo 'Installing libraries'
	@for library in $(libraries); do \
		echo $$library; \
		cp -r $(library_path)/$$library $(PREFIX)/lib/$$library; \
	done
uninstall:
	@echo 'Uninstalling libraries'
	@for library in $(libraries); do \
		echo $$library \
		rm -r $(library_path)/$$library $(PREFIX)/lib/$$library; \
	done
build-documentation:
	# bashdoc
