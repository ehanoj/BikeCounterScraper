set terminal pngcairo dashed background rgb 'white' enhanced fontscale 1.0 size 1900, 1000 dashlength .5
set output 'csvSumTotalWeek/BikeCounterBrnoTotalWeek.png'
# set output outputVAR
set datafile separator ','
set autoscale

# debug
set print
#print xstart, xend

# title and legend
set title "{/*1.5 Cyclists per week via permanent videodetectors in Brno}\n data: BKOM a.s., analýza: Brno na kole z.s. 2021"
set key left 

# axis X
#set xdata time
#set timefmt "%Y-%m-%d"
#set format x "%Y-%m-%d"

#xstart = "2020-06-01"
#xstart = "2020-08-01"
#xend = "2021-03-31"
#set xrange [xstart:xend]
#set xtics xstart, 7*24*60*60
#set xtics rotate by 90 right
#set xtics out offset 0,0

# axis Y
set ylabel "Cyclists per week"
#set yrange [0:*<4000]
set ytics nomirror
set y2label "Rains per week [millimeter]"
set y2range [0:*]
set y2tics nomirror

# line style
set termoption dash
show style line
set style data lines


SECPERWEEK = 3600.*24.*7.
Y_W(y,w) = y + SECPERWEEK * w

#     "meteoCsvDay/rain.csv" using 1:2 axis x1y2 title "srážky Brno, ul. Veveří" with boxes lc rgb  "#00BFFF" fill solid 0.25 border 1.0, \
# plot a data
plot  \
     "csvSumTotalWeek/wKomin.csv"         using 1:2 title columnheader(1) dt 1 lw 2 

#     "csvSumTotalWeek/wPisarky.csv"       using 1:2 title columnheader(1) dt 1 lw 2, \
#     "csvSumTotalWeek/wJundrov.csv"       using 1:2 title columnheader(1) dt 1 lw 2, \
#     "csvSumTotalWeek/wRenneska1+2.csv"   using 1:2 title columnheader(1) dt 1 lw 2, \
#     "csvSumTotalWeek/wIkea.csv"          using 1:2 title columnheader(1) dt 1 lw 2, \
#     "csvSumTotalWeek/wObrany.csv"        using 1:2 title columnheader(1) dt 2 lw 3, \
#     "csvSumTotalWeek/wCernovice.csv"     using 1:2 title columnheader(1) dt 2 lw 3, \
#     "csvSumTotalWeek/wBIvanovice1+2.csv" using 1:2 title columnheader(1) dt 2 lw 3, \
#     "csvSumTotalWeek/wKounicova1+2.csv"  using 1:2 title columnheader(1) dt 3 lw 4, \
#     "csvSumTotalWeek/wLidicka1+2.csv"    using 1:2 title columnheader(1) dt 3 lw 4, \
#     "csvSumTotalWeek/wNovesady1+2.csv"   using 1:2 title columnheader(1) dt 3 lw 4, \
#     "csvSumTotalWeek/wKralovopolska.csv" using 1:2 title columnheader(1) dt 3 lw 4
