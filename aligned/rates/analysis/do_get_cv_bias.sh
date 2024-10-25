#!/bin/bash 

plumedFile=$1

data_dir= #path to colvar and bias data
label=$(basename $plumedFile |cut -f 1 -d '.')

for f in `seq -40.0 10.0 40.0`
do
        max_run=45
	if (( $(echo "$f == 0.0" | bc -l) ));
	then
		max_run=55
	fi
	for i in `seq 26 1 ${max_run}`
        do
                echo "force: ${f} run: ${i}"
		#outputprefix=${data_dir}/${label}_pn_${f}/${i}/${i}_rate_pullVt
                #python extract_cv_bias_column.py ${outputprefix}.colvar.out ${outputprefix}.opes.out ${outputprefix}.cvs_bias.dat
        done
done
