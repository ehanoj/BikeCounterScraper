# NEED VAR dataVAR, outputVAR, titleVAR
# 
# #####################
#
set terminal pngcairo  background rgb 'white' enhanced fontscale 1.0 size 1400, 600 
#set output 'Renneska1+2.png'
set output outputVAR
set datafile separator ','
set autoscale

# debug
set print
#print xstart, xend

# title and legend
set title "{/*1.5 Cyclists and pedestrians per hour via permanent videodetector in Brno - ".titleVAR."} \n data: BKOM a.s., analýza: Brno na kole z.s. 2020"
set key left

stats dataVAR using (strptime("%Y-%m-%d %H:%M", stringcolumn(1))) nooutput
t = int(STATS_min)
t_start = t - tm_hour(t)*60*60 - tm_min(t)*60 - tm_sec(t)
num_days = 2 + (int(STATS_max) - t)/(24*60*60)

# axis X
set xdata time
set timefmt "%Y-%m-%d %H:%M"
#set format x "%Y-%m-%d"
xstart = "2020-07-13"
xend = "2020-07-20"
set xrange [xstart:xend]
set xtics format "%H"
set xtics 3*60*60
set xtics rotate by 25 right
set xtics out offset 0,0
set xtics norangelimit 
set for [i=1:num_days] xtics add (strftime('%Y-%m-%d', t_start+(i-1)*24*60*60) t_start+(i-1)*24*60*60)
set format x '%H'

# auto weekend generate as object and label
epoch(s) = int(system(sprintf("date -d \"%s\" +%s", s)))
xstart = epoch(xstart)
xend = epoch(xend)
do for [indx = xstart+6*24*60*60 : xend : 7*24*60*60] {
   seco = indx + 1*24*60*60
   set object indx rectangle center indx, graph .7/2 size 2*24*60*60, graph .7 fs solid fc rgb "#FFC0CB" lw 0 behind
   set label "Weekend" at indx, graph .68 right textcolor rgb "#AAAAAA" font "Arial,11" offset 3,0
}


# axis Y
set ylabel "Count of users per hour"
set yrange [0:400]
set ytics nomirror
set y2label "Rains per hour [millimeter]"
set y2range [0:20]
set y2tics nomirror

# line style
set style data lines




#xticlabel(label($1))

#set key fixed right top vertical Right noreverse noenhanced autotitle nobox
#set style increment default
#set xtics border in scale 1,0.5 nomirror rotate by 90  autojustify
#set xtics ()
#set xrange [ 2020.5 : 2020.6 ] noreverse writeback
## Last datafile plotted: "immigration.dat"

plot \
     "meteoCsv/rain_hour.csv" using 1:2 axis x1y2 title "srážky Brno, ul. Veveří" with boxes lc rgb  "#00BFFF" fill solid 0.25 border 1.0, \
     dataVAR using 1:2 title columnheader(2) lw 3, \
     dataVAR using 1:3 title columnheader(3) 
