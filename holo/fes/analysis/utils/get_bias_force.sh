#!/bin/bash

inputFile=$1
force=$2
data_dir= #colvars directory
label=$(basename $inputFile |cut -f 1 -d '.')

for xtc in `seq 1 1 20`
do
	trajprefix=${data_dir}/${label}_pn_${force}/${xtc}/${xtc}_fes_pullVt
        outputprefix=${data_dir}/${label}_pn_${force}/${xtc}/${xtc}_fes_pullVt_rerunf
        traj=${trajprefix}.full.xtc
        forcepN=`echo "scale=10;$force*0.01439" | bc` # convert pN to kcal/molA	
	for bias in `seq 1 1 20`
	do
		echo "Force $force run $xtc window $bias "
		input=${data_dir}/${label}_pn_${force}/${bias}/${bias}_fes_pullVt
		output=${outputprefix}_${bias}
		plumed_file=${outputprefix}_${bias}f.dat

		sed -e "s,_FORCE_,${forcepN},g" -e "s,_INPUT_,$input,g" -e "s,_OUTPUT_,$output,g" -e "s,_TRAJ_,${trajprefix},g" $inputFile > $plumed_file
		bash utils/driver_bias.sh ${plumed_file} ${traj}
	done
done
