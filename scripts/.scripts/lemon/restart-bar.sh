#!/bin/sh
killall lemonbar 2>/dev/null
killall lemontopc 2>/dev/null
killall lemonbartop 2>/dev/null
$SCRIPTS_FOLDER/lemon/lemonbartop
