#!/bin/bash
DIR="xml"
out="csv"

waitforjobs() {
    while test $(jobs -p | wc -w) -ge "$1"; do wait -n; done
}

# -------------------
for i in $DIR/*.htm; do
        o=${i#"$DIR"}
        o=$out${o%".htm"}".csv"
        echo $i ">" $o
        if [ ! -f "$o" ]; then  
          waitforjobs 10
          python3 ./html2csv.py < $i > $o &
	fi
done
