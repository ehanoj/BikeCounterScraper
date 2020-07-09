#!/bin/bash
DIR="csvSumTotal"
DIR2="csvSumTotalDay"
file="index.html"

# -------------------
echo "<!DOCTYPE html><html><body>" > $file

for i in $( ls $DIR2/*.png; ls $DIR/*.png; ); do
        echo "<img src=\"$i\">"  >> $file
done

echo "</body></html>" >> $file
