set terminal pngcairo dashed background rgb 'white' enhanced fontscale 1.0 size 1900, 1000 dashlength .5
set output 'csvSumTotalDay/BikeCounterBrnoTotal.png'
# set output outputVAR
set datafile separator ','
set autoscale

# debug
set print
#print xstart, xend

# title and legend
set title "{/*1.5 Cyclists per day via permanent videodetectors in Brno}\n data: BKOM a.s., analýza: Brno na kole z.s. 2020"
set key left 

# axis X
set xdata time
set timefmt "%Y-%m-%d"
set format x "%Y-%m-%d"

#xstart = "2020-06-01"
xstart = "2020-08-31"
xend = "2021-03-30"
set xrange [xstart:xend]
set xtics xstart, 7*24*60*60
set xtics rotate by 90 right
set xtics out offset 0,0

# axis Y
set ylabel "Cyclists per day"
set yrange [0:*<4000]
set ytics nomirror
set y2label "Rains per day [millimeter]"
set y2range [0:*]
set y2tics nomirror

# line style
set termoption dash
show style line
set style data lines

# auto weekend generate as object and label
epoch(s) = int(system(sprintf("date -d \"%s\" +%s", s)))
xstart = epoch(xstart)
xend = epoch(xend)
do for [indx = xstart+5.6*24*60*60 : xend : 7*24*60*60] {
   seco = indx + 1*24*60*60
   set object indx rectangle center indx, graph .7/2 size 1.7*24*60*60, graph .7 fs solid fc rgb "#FFC0CB" lw 0 behind
   set label "Weekend" at indx, graph .68 right textcolor rgb "#AAAAAA" font "Arial,11" offset 3,0
}

# plot a data
plot  \
     "meteoCsvDay/rain.csv" using 1:2 axis x1y2 title "srážky Brno, ul. Veveří" with boxes lc rgb  "#00BFFF" fill solid 0.25 border 1.0, \
     "csvSumTotalDay/dKomin.csv"         using 1:2 title columnheader(1) dt 1 lw 2, \
     "csvSumTotalDay/dPisarky.csv"       using 1:2 title columnheader(1) dt 1 lw 2, \
     "csvSumTotalDay/dJundrov.csv"       using 1:2 title columnheader(1) dt 1 lw 2, \
     "csvSumTotalDay/dRenneska1+2.csv"   using 1:2 title columnheader(1) dt 1 lw 2, \
     "csvSumTotalDay/dIkea.csv"          using 1:2 title columnheader(1) dt 1 lw 2, \
     "csvSumTotalDay/dObrany.csv"        using 1:2 title columnheader(1) dt 2 lw 3, \
     "csvSumTotalDay/dCernovice.csv"     using 1:2 title columnheader(1) dt 2 lw 3, \
     "csvSumTotalDay/dBIvanovice1+2.csv" using 1:2 title columnheader(1) dt 2 lw 3, \
     "csvSumTotalDay/dKounicova1+2.csv"  using 1:2 title columnheader(1) dt 3 lw 4, \
     "csvSumTotalDay/dLidicka1+2.csv"    using 1:2 title columnheader(1) dt 3 lw 4, \
     "csvSumTotalDay/dNovesady1+2.csv"   using 1:2 title columnheader(1) dt 3 lw 4, \
     "csvSumTotalDay/dKralovopolska.csv" using 1:2 title columnheader(1) dt 3 lw 4
