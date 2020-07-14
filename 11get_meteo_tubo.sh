#!/bin/bash
DIR="meteo"
out="meteoCsv"


startdate=$(date -I -d "2020-06-01") || exit -1
enddate=$(date -I) #today

i="$startdate"
while [ "$i" != "$enddate" ]; do 
  echo $i
  y=$( date +%Y -d "$i" )
  m=$( date +%m -d "$i" )
  d=$( date +%d -d "$i" )


  ofile1="ra-$i.csv"
  ofile2="te-$i.csv"

  if [ ! -f "$DIR/$ofile1" ]; then 
    curl 'http://tubo.fce.vutbr.cz/new/meteoExport_csv.asp' --data-raw "akce=EXPORT&databaze=THIES&velicina=THIES_17&datumDen=$d&datumMesic=$m&datumRok=$y&casOd=0&casDo=24" > $DIR/$ofile1
  fi
  if [ ! -f "$DIR/$ofile2" ]; then
    curl 'http://tubo.fce.vutbr.cz/new/meteoExport_rinex.asp' --data-raw "akce=EXPORT&databaze=ADAM&ADAM_1_3=on&datumDen=$d&datumMesic=$m&datumRok=$y&casOd=0&casDo=24" > $DIR/$ofile2
  fi
  i=$(date -I -d "$i + 1 day")
done



# -------------------
#for i in $DIR/*.htm; do
#        o=${i#"$DIR"}
#        o=$out${o%".htm"}".csv"
#        echo $i ">" $o
#        cat $i | iconv -f WINDOWS-1250 -t UTF-8 | sed "s/,/./g" | awk '(FNR > 44 && FNR < 77) { print }' | python3 ./html2csv.py > $o
#done
