#!/bin/sh
if [ $(xgetres lemon.textonly) = "0" ]; then
	xgetres $1.symbol
else
	xgetres $1.text
fi

