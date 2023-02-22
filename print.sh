#!/bin/bash
for file in $1/*; do 
	echo "File: $file"
	cat "$file"
done
