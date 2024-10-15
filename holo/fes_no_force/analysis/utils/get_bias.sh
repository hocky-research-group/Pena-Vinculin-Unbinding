#!/bin/bash

inputFile=$1
force=$2

data_dir=../outputs
label=$(basename $inputFile |cut -f 1 -d '.')

for xtc in `seq 26 1 45`
	do
		trajprefix=${data_dir}/${label}_pn_${force}/${xtc}/${xtc}_fes_pullVt
		outputprefix=${data_dir}/${label}_pn_${force}/${xtc}/${xtc}_fes_pullVt_rerun
		for bias in `seq 26 1 45`
		do
			echo "Force $force run $xtc window $bias "
			input=${data_dir}/${label}_pn_${force}/${bias}/${bias}_fes_pullVt
			output=${outputprefix}_${bias}
			plumed_file=${outputprefix}_${bias}.dat
			sed  -e "s,_INPUT_,$input,g" -e "s,_OUTPUT_,$output,g" -e "s,_TRAJ_,$trajprefix,g" $inputFile > $plumed_file
			bash utils/driver.sh ${plumed_file} 
		done
done
