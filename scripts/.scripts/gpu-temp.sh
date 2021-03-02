#!/bin/sh
nvidia-smi | grep -o "[0-9]*[0-9][0-9]C"
