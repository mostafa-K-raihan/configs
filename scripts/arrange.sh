#!/bin/sh

. ./list.sh

if [ ! -d "$1" ]; then
	echo "$1 - is not a directory"
	echo "Aborting"
	exit 1
fi

list_files $1
