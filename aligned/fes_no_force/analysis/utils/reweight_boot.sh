#!/bin/bash

plumedFile=$1
data_dir=$2
label=$(basename $plumedFile |cut -f 1 -d '.')

for f in `seq 0.0 30.0 0.0`
do
#	outputprefix=${data_dir}/${label}_pn_${f}
	if (( $(echo "$f < 0.0" | bc -l) ));
        then
		minproj=65
        	maxproj=77
		minext=39
		maxext=49
        else
		minproj=65
        	maxproj=77
		minext=39
		maxext=49

        fi
        if (( $(echo "$f == 0.0" | bc -l) ));
        then
		minproj=65
        	maxproj=76
		minext=38
		maxext=49
        fi
		
    	for boot in `seq 0 1 99`
	do

	outputprefix=${data_dir}/${label}_pn_${f}/${boot}/boot
	outdir=${data_dir}/${label}_pn_${f}/${boot}
	mkdir -p $outdir
	plumed_file=${outputprefix}.reweight${boot}.dat
	echo $plumed_file
	
	sed -e "s,_FORCE_,$f,g" -e "s,_OUTPUT_,${outputprefix},g" -e "s,_BOOT_,${boot},g" \
		-e "s,_MINP_,$minproj,g" -e "s,_MAXP_,$maxproj,g" \
		-e "s,_MINE_,$minext,g" -e "s,_MAXE_,$maxext,g" $plumedFile > ${plumed_file}

	bash utils/driver.sh ${plumed_file}
	done
done
