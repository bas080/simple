#!/bin/bash
base="textures"
mkdir $base
while read element; do
  elementCode=`echo $element | grep -oP "(\s|^)[a-zA-Z]{1,3}"`
  elementNumb=`echo $element | grep -oP "[0-9]{1,3}"`
  #elementGrou=`echo $element | grep -oP "(?<=[0-9] ).+"`
  
  convert base.png +antialias -gravity Center -annotate -0-0 "$elementCode" -gravity NorthWest -pointsize 8 -annotate +3+1 "$elementNumb" "$base/$elementCode.png"
done < "elements.txt"
