#!/bin/bash
declare -A stan

stan[Renneska2]=5
stan[Renneska1]=9
stan[Pisarky]=13
stan[Obrany]=17
stan[Novesady2]=21
stan[Novesady1]=25
stan[Lidicka2]=29
stan[Lidicka1]=33
stan[Kralovopolska]=37
stan[Kounicova2]=41
stan[Kounicova1]=45
stan[Komin]=49
stan[Jundrov]=53
stan[Ikea]=57
stan[Cernovice]=61
stan[BIvanovice2]=65
stan[BIvanovice1]=69

# -------------------

for item in "${!stan[@]}"; 
  do
    row=${stan[$item]}
    oufile=${item}.csv
    printf "$item is in $row > $oufile \n"
    n=0
    for infile in csv/*.csv; do
        hour=${infile#"csv/BikeDetector"}
        hour=${hour%"00.csv"}":00"
        hour=${hour//_/ }
        if [ "$n" = "0" ] ; then
           echo $infile ">" $hour
           cat $infile | sed -n "1p;$((row - 3))p" | sed "s/Název,,cyklisté,chodci,cyklisté,chodci/time,cyklisté,chodci/g" > csvSum/$oufile
        fi
        n=1
        (cat $infile ; echo) | sed -n "$((row))p" | sed "s/365 dnů/$hour/g" | sed -e 's/\(.\{10\}\)./\1 /' >> csvSum/$oufile
    done
    awk -F, -v OFS=, '{ if (NR > 2) {co=c;po=p; c=$2+$4;p=$3+$5; if (NR > 3) {dc=c-co;dp=p-po; print $1,dc,dp}} else {print $0} }' csvSum/$oufile > csvSumTotal/$oufile
done


