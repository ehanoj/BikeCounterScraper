#!/bin/bash
DIR="csvSumTotal"
for i in $DIR/*.csv; do
    iname=${i%".csv"}
    iname=${iname#"$DIR/"}
    echo $i $iname
    gnuplot -e "dataVAR='${i}'; titleVAR='${iname}'; outputVAR='${i%".csv"}.png'" histogram.gnu 
done
cp $DIR/*+*.png ./
cp `ls $DIR/*.png | egrep -v '.+[!?1|2|A|B].png$'` ./
