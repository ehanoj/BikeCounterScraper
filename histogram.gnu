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
#set xrange ["2020-06-29":"2020-07-05"]

epoch(s) = int(system(sprintf("date -d \"%s\" +%s", s)))
xstart = epoch("2020-07-06")
xend = epoch("2020-07-13")
set print
print xstart, xend

set xrange [xstart:xend]

#set xtics autofreq
do for [indx = xstart+6*24*60*60 : xend : 7*24*60*60] {
   seco = indx + 1*24*60*60
   set object indx rectangle center indx, graph .7/2 size 2*24*60*60, graph .7 fs solid fc rgb "#EEEEEE" lw 0 behind
   set label "Weekend" at indx, graph .68 right textcolor rgb "#AAAAAA" offset 2,0
  # set label "Weekend".indx." ".strftime('%Y-%m-%d',indx) at "2020-06-01", graph .71
}
set xtics 3*60*60
set for [i=1:num_days] xtics add (strftime('%Y-%m-%d', t_start+(i-1)*24*60*60) t_start+(i-1)*24*60*60)
set format x '%H'

#set xrange [*:*]
set xtics rotate by 25 right
set xtics out offset 0,0

set style data lines
#set yrange [0:*<400]
set yrange [0:400]

set ylabel "Count of users per hour"
set title "{/*1.5 Cyclists and pedestrians per hour via permanent videodetector in Brno - ".titleVAR."} \n data: BKOM a.s., analýza: Brno na kole z.s. 2020"


#xticlabel(label($1))

#set key fixed right top vertical Right noreverse noenhanced autotitle nobox
#set style increment default
#set xtics border in scale 1,0.5 nomirror rotate by 90  autojustify
set xtics norangelimit 
#set xtics ()
#set xrange [ 2020.5 : 2020.6 ] noreverse writeback
## Last datafile plotted: "immigration.dat"

plot dataVAR using 1:2 title columnheader(2) lw 3, \
     dataVAR using 1:3 title columnheader(3) 
