#!/bin/sh
sed -i \
         -e 's/rgb(0%,0%,0%)/#9da9a0/g' \
         -e 's/rgb(100%,100%,100%)/#1e2326/g' \
    -e 's/rgb(50%,0%,0%)/#1e2326/g' \
     -e 's/rgb(0%,50%,0%)/#446460/g' \
 -e 's/rgb(0%,50.196078%,0%)/#446460/g' \
     -e 's/rgb(50%,0%,50%)/#9da9a0/g' \
 -e 's/rgb(50.196078%,0%,50.196078%)/#9da9a0/g' \
     -e 's/rgb(0%,0%,50%)/#1e2326/g' \
	"$@"
