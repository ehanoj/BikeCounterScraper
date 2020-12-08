#!/bin/bash
DIR="meteo"
outDIR="meteoCsv"

waitforjobs() {
    while test $(jobs -p | wc -w) -ge "$1"; do wait -n; done
}

# rain-------------------
o=$outDIR/rain_hour.csv
rm $o
for i in $DIR/ra-*.csv; do
    date=${i#"$DIR/"}
    date=${date%".csv"}
    date=${date#"ra-"}
    echo $i ">" $o $date
    waitforjobs 10
    cat $i | sed '1,4d' | head -n -6 | sed 's/,/\./g' | sort -r | awk -F: -v OFS=: '!a[$1]++ {print $0}' | sort | awk -F";" -v OFS=, -v date="$date" 'BEGIN {prev=0} {d=$3-prev; print date" "$2,d; prev=$3}' >> $o &
done

# temp-------------------
o=$outDIR/tempe_hour.csv
rm $o
for i in $DIR/te-*.csv; do
    date=${i#"$DIR/"}
    date=${date%".csv"}
    date=${date#"te-"}
    echo $i ">" $o $date
    waitforjobs 10
    cat $i | sed '1,8d' | sed 's/,/\./g' | sort -r | awk -F" " -v OFS="," -v date="$date" '!a[$4]++ {print date" "$4":"$5,$7}' | sort >> $o &
done
