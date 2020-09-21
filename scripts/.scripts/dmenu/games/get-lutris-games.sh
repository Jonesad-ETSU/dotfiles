#!/bin/sh
set lutrisDir='$HOME/.local/share/applications/'
ls $lutrisDir | grep lutris | cut -d '.' -f 3
