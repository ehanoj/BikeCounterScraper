DIR="csvSumTotal"
oDIR="csvSumTotalDay"

for i in $DIR/*.csv; do
    o=${i#"$DIR/"}
    o=${o%".csv"}
    echo "$i > $o"

    awk -F, -v OFS=, '{ \
	    if (NR > 2) \
		{ split($1, date," "); \
		d=date[1]; \
		c[d] += $2; \
		p[d] += $3; } \
	    else \
		{ print $0 } \
	    }
            END{ for (x in c) print x, c[x], p[x] }' $i  | awk 'NR==1{a=$0;next}NR==2{b=$0; print $0"\n"a;next}{print $0;}' | awk 'NR<3{print $0;next}{print $0| "sort"}'  > $oDIR/d$o.csv
done;
gnuplot histogramTotal.gnu 
