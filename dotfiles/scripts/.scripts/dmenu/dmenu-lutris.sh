#!/bin/sh
set lutrisDir='/home/jonesad/.local/share/applications/'
ls $lutrisDir | grep lutris | cut -d '.' -f 3
