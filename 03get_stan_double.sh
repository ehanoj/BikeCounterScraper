DIR="csvSumTotal"
n=1
for i in $( ls $DIR | egrep '^[a-zA-Z]*[12]{1}.csv$' ); do
    if (( $n % 2 )); then
	echo $n
        ifirst=$i
    else
    echo $n $i $ifirst
    awk -F, -v OFS=, 'NR==FNR{a[$1]=$2; b[$1]=$3; next}; { if (FNR > 2) {print $1,$2+a[$1],$3+b[$1]} else {print $0} }' $DIR/$ifirst $DIR/$i | sed "s/\([A-Za-z]+*\) [B|2]/\1 1+2/g" | sed "s/Název,,cyklisté,chodci,cyklisté,chodci/time,cyklisté,chodci/g" > $DIR/${ifirst%".csv"}+2.csv
    fi
    n=$(( $n+1 ))

done;
