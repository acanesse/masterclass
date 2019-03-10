#!/usr/bin/env bash

# Script to fill in the certificates from tempate

# usage:
# Update the date in template.svg (with text editor) and create a txt file with all the names (1 name per line).
# chmod +x script.sh
# ./script.sh

# Required packages: to install inkscape and svg-pdf converter:
# sudo apt-get install inkscape
# sudo apt-get install librsvg2-bin


i=0
file="names.txt"

while IFS= read -r line
do
    echo "$line"
	file='certificate-'$i'.svg'
	cp template.svg $file
	sed -i "s/Name/$line/g" "$file"
	inkscape "$file" --export-pdf="certificate-$i.pdf"
	rsvg-convert -f pdf -o "certificate-$i.pdf" "$file"
    i=$[$i+1]
done < $file
pdfunite $(ls -v certificate-*.pdf) certificates-combined.pdf


