set terminal pngcairo dashed background rgb 'white' enhanced fontscale 1.0 size 1900, 1000 dashlength .5
set output 'BikeCounterBrnoTotal.png'
#set output outputVAR
set datafile separator ','

set autoscale
set key left

#stats dataVAR using (strptime("%Y-%m-%d %H:%M", stringcolumn(1))) nooutput
#t = int(STATS_min)
#t_start = t - tm_hour(t)*60*60 - tm_min(t)*60 - tm_sec(t)
#num_days = 2 + (int(STATS_max) - t)/(24*60*60)

set xdata time
set timefmt "%Y-%m-%d"
set format x "%Y-%m-%d"
#set xtics format "%H"
#set xrange ["2020-06-22":"2020-06-28"]
set xrange ["2020-06-01":*]
#set xtics autofreq
do for [indx in "06 13 20 27"] {
  seco = indx + 1
  set object indx rectangle from "2020-06-".indx, graph 0 to "2020-06-".seco, graph .7 fs solid fc rgb "#EEEEEE" behind
  set label "Weekend" at "2020-06-06", graph .71
}

#set xtics 3*60*60
#set for [i=1:num_days] xtics add (strftime('%Y-%m-%d', t_start+(i-1)*24*60*60) t_start+(i-1)*24*60*60)
#set format x '%H'

#set xtics rotate by 25 right
#set xtics out offset 0,0

set termoption dash
show style line
set style data lines
#set yrange [0:*<400]
#set yrange [0:400]

set ylabel "Count (day)"
set title "{/*1.5 Cyclist per day from permanent videodetectors in Brno}\n data: BKOM a.s., analýza: Brno na kole z.s. 2020"

#set key fixed right top vertical Right noreverse noenhanced autotitle nobox
#set style increment default
#set xtics border in scale 1,0.5 nomirror rotate by 90  autojustify
#set xtics norangelimit 
#set xtics ()
#set xrange [ 2020.5 : 2020.6 ] noreverse writeback
## Last datafile plotted: "immigration.dat"

plot "csvSumTotalDay/dKomin.csv"         using 1:2 title columnheader(1) dt 1 lw 2, \
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
