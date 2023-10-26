#!/bin/bash
#
## This will list all the entries in a directory
# The input $1 will be the directory
#
#
list_files() {

	for entry in "$1"/*; do
		if [ -d "$entry" ]; then
			echo "d"$'\t'"$(basename "$entry")"
		else
			echo "f"$'\t'"$(basename "$entry")"
		fi
	done
}
