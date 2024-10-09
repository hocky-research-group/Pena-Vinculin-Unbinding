#!/bin/bash

plumedFile=$1
data_dir=$2

for f in `seq -30.0 10.0 30.0`
do
	label=$(basename $plumedFile |cut -f 1 -d '.')
	outputprefix=${data_dir}/${label}_pn_${f}
	plumed_file=${outputprefix}.reweightrerun.dat
	echo $plumed_file
    	if (( $(echo "$f < 0.0" | bc -l) ));
	then
                minproj=67
                maxproj=77
                minext=38
                maxext=49
        else
                minproj=64
                maxproj=74
                minext=38
                maxext=49

        fi
        if (( $(echo "$f == 0.0" | bc -l) ));
        then
                minproj=65
                maxproj=75
                minext=38
                maxext=49
        fi
	
	sed -e "s,_FORCE_,$f,g" \
		-e "s,_MINP_,$minproj,g" -e "s,_MAXP_,$maxproj,g" \
		-e "s,_MINE_,$minext,g" -e "s,_MAXE_,$maxext,g" $plumedFile > ${plumed_file}

	bash utils/driver.sh ${plumed_file}
done
