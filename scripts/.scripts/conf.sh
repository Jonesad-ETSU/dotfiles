#!/bin/bash
[ ! -d /tmp/conf/ ] && mkdir -p /tmp/conf
[ -f /tmp/conf/$1 ]\
       	&& (cat /tmp/conf/$1) \
	|| (yq .$1 ~/conf.yml | tr -d '"'| tee /tmp/conf/$1) 
