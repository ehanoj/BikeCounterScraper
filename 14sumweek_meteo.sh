#!/bin/bash
DIR="meteoCsvDay"
outDIR="meteoCsvWeek"

# rain-------------------
o=$outDIR/rain.csv
rm $o
i=$DIR/ra*.csv;
cat $i | sed 's/ /,/g' | awk -F, -v OFS=, '{ s[$1] += $3 } END { for (i in s) { print i, s[i]; } }' | sort >> $o


# temp-------------------
#o=$outDIR/tempe.csv
#rm $o
#for i in $DIR/te-*.csv; do
#    echo $i
#    cat $i | awk -F, -v OFS=, '{s+=$3} END {print $1,s/ NR}' >> $o
#done
