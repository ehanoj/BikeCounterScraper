# NEED VAR dataVAR, outputVAR, titleVAR
# 
# #####################
#
set terminal pngcairo  background rgb 'white' enhanced fontscale 1.0 size 1400, 600 
#set output 'Renneska1+2.png'
set output outputVAR
set datafile separator ','

set autoscale
set key left

stats dataVAR using (strptime("%Y-%m-%d %H:%M", stringcolumn(1))) nooutput
t = int(STATS_min)
t_start = t - tm_hour(t)*60*60 - tm_min(t)*60 - tm_sec(t)
num_days = 2 + (int(STATS_max) - t)/(24*60*60)

set xdata time
set timefmt "%Y-%m-%d %H:%M"
#set format x "%Y-%m-%d"
set xtics format "%H"
#set xrange ["2020-06-22":"2020-06-28"]
set xrange ["2020-06-29":"2020-07-05"]
#$set xtics autofreq
set object 1 rectangle from "2020-06-26",graph 0 to "2020-06-28",graph 1 fs solid fc rgb "#DDDDDD" behind

set xtics 3*60*60
set for [i=1:num_days] xtics add (strftime('%Y-%m-%d', t_start+(i-1)*24*60*60) t_start+(i-1)*24*60*60)
set format x '%H'

#set xrange [*:*]
set xtics rotate by 25 right
set xtics out offset 0,0

set style data lines
#set yrange [0:*<400]
set yrange [0:400]

set ylabel "Count (hour)"
set title "{/*1.5 Cyclist and pedestrian per hour from permanent videodetector in Brno".titleVAR."} \n data: BKOM a.s., analýza: Brno na kole z.s. 2020"

#set key fixed right top vertical Right noreverse noenhanced autotitle nobox
#set style increment default
#set xtics border in scale 1,0.5 nomirror rotate by 90  autojustify
set xtics norangelimit 
#set xtics ()
#set xrange [ 2020.5 : 2020.6 ] noreverse writeback
## Last datafile plotted: "immigration.dat"

plot dataVAR using 1:2 title columnheader(2) lw 3, \
     dataVAR using 1:3 title columnheader(3) 
