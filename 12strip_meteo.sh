#!/bin/bash
DIR="meteo"
outDIR="meteoCsv"

# rain-------------------
for i in $DIR/ra-*.csv; do
    o=${i#"$DIR/"}
    date=${o%".csv"}
    date=${date#"ra-"}
    o=$outDIR/$o
    echo $i ">" $o $date
    cat $i | sed '1,4d' | head -n -6 | sed 's/,/\./g' | sort -r | awk -F: -v OFS=: '!a[$1]++ {print $0}' | sort | awk -F";" -v OFS=, -v date="$date" 'BEGIN {prev=0} {d=$3-prev; print date,$2,d; prev=$3}' > $o
done

# temp-------------------
for i in $DIR/te-*.csv; do
    o=${i#"$DIR/"}
    date=${o%".csv"}
    date=${date#"te-"}
    o=$outDIR/$o
    echo $i ">" $o $date
    cat $i | sed '1,8d' | sed 's/,/\./g' | sort -r | awk -F" " -v OFS="," -v date="$date" '!a[$4]++ {print date,$4":"$5,$7}' | sort > $o
done
