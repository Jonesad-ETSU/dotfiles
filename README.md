#################################
#    Jonesad-ETSU's dotfiles	#
#################################

Welcome to my dotfiles. Here you will find my configuration settings as well as scripts designed for portability where possible and the ability to use them to setup a system much more easily than if one has to manually edit everything.

Included:
.scripts =>
	 contains scripts that print useful information such as battery percentage, time, system temperature, etc.  
	contains my configuration scripts ( discussed more below ).
	.conf.yml =>
		file that contains most of the configuration settings for my system. Looking to expand it further into some other elements such as modifying gtk themes and system behavior. 
	conf.sh =>
		utility that reads from conf.yml
		takes configuration name as parameter with global "." implied
	conf_to_script.sh =>
		configuration utility that generates configuration files from .template files that are defined in a use file given to the program.
		a use file is simply a list of modules that are newline-delimited with ".template" implied.
		using this utility allows the user to utilize the following syntax items:
			^<x> => uses conf.sh to read from conf.yml
			@<x> => uses get-symbol.sh to read from conf.yml and parse whether the user wants text-only output or nerd-font output.
			!<x:shift> => uses chbright-color.sh to modify a color x read from conf.yml by conf.sh.   
	patch-file.sh => 
		takes a configuration file as output

Along with that, there are various miscellaneous tools for printing things to bars and the like. 

##################
#  Installation  #
##################

To install this github repo, clone with 'git clone https://github.com/jonesad-etsu/dotfiles.git' inside of any shell or use other tool as desired. After cloning, navigate to the new folder and use the appropriate installation script depending on your version of linux. Currently supported versions are Void Linux and Arch Linux. From there, stow is installed which will create symbolic links from the dotfiles folder to the respective folders. GNU/Stow uses the parent directory of the current as its root and installs each folder you give it by first going into that folder and then creating a link from root.

Example of stow: folder 'stuff' contains the nested file '.config/stuff/stuff.conf'- stow will link the stuff.conf file to '../.config/stuff/stuff.conf'  
