#!/bin/bash
CONFIG_OPT=$(yq .$1 ~/conf.yml)
#if [[ "$CONFIG_OPT" == *"#"* ]]; then
#	printf "%s\n" $CONFIG_OPT
#	exit
#else
	echo $CONFIG_OPT | tr -d '"' 
#	exit
#fi
