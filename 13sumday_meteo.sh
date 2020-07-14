#!/bin/bash
DIR="meteoCsv"
outDIR="meteoCsvDay"

# rain-------------------
o=$outDIR/rain.csv
rm $o
for i in $DIR/ra-*.csv; do
    echo $i
    cat $i | awk -F, -v OFS=, '{s+=$3} END {print $1,s}' >> $o
done

# temp-------------------
o=$outDIR/tempe.csv
rm $o
for i in $DIR/te-*.csv; do
    echo $i
    cat $i | awk -F, -v OFS=, '{s+=$3} END {print $1,s/ NR}' >> $o
done
