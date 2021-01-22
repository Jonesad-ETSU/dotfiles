#!/bin/sh
pkill lemonbar lemontopc lemonbartop 2>/dev/null
exec $SCRIPTS_FOLDER/lemon/lemonbartop
