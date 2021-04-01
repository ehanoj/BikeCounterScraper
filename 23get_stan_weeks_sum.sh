DIR="csvSumTotalDay"
oDIR="csvSumTotalWeek"

for i in $DIR/*.csv; do
    o=${i#"$DIR/d"}
    o=${o%".csv"}
    echo "$i > $o"

    awk -F, -v OFS=, '{ \
	    if (NR > 2) \
		{ split($1, d,"-"); \
        w = strftime("%W", mktime(d[1]" "d[2]" "d[3]" 00 00 00"));
        date=d[1]""w
		c[date] += $2; \
		p[date] += $3; } \
	    else \
		{ print $0 } \
	    }
            END{ for (x in c) print x, c[x], p[x] }' $i  | awk 'NR==1{a=$0;next}NR==2{b=$0; print $0"\n"a;next}{print $0;}' | awk 'NR<3{print $0;next}{print $0| "sort"}'  > $oDIR/w$o.csv
done;
gnuplot histogramTotalWeek.gnu
cp $oDIR/*.png ./subsel
