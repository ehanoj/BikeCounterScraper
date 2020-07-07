#!/bin/bash
DIR="xml"
out="csv"

# -------------------
for i in $DIR/*.htm; do
        o=${i#"$DIR"}
        o=$out${o%".htm"}".csv"
        echo $i ">" $o
        python3 ./html2csv.py < $i > $o
done
