#!/bin/bash
DIR="meteo"
out="meteoCsv"

# -------------------
for i in $DIR/*.htm; do
        o=${i#"$DIR"}
        o=$out${o%".htm"}".csv"
        echo $i ">" $o
        cat $i | iconv -f WINDOWS-1250 -t UTF-8 | sed "s/,/./g" | awk '(FNR > 44 && FNR < 77) { print }' | python3 ./html2csv.py > $o
done
