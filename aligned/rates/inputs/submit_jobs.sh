#!/bin/bash

plumedFile=$1
ns=$2
data_dir= # output directory

#----Loop through forces----
for f in `seq -40.0 10.0 40.0`
do	

	force=`echo "scale=10;$f*0.01439" | bc` # convert pN to kcal/molA
	echo "-------- ${f} --> ${force} --------"
	if (( $(echo "${f} < 0" | bc -l) ));
       	then
		anc=85
		afr=0.0
	else
		anc=55
		afr=50
	fi
	for i in `seq 26 1 45`
	do
		echo $i
		tpr=md_fes_${i}.tpr # config tpr
		label=$(basename $plumedFile |cut -f 1 -d '.')
		outputprefix=${data_dir}/${label}_pn_${f}/${i}/${i}_rate_pullVt
		full_label=$(basename $outputprefix)
		outdir=$(dirname $outputprefix)
		mkdir -p $outdir
		plumed_file=${outputprefix}.pull.dat
		sed -e "s,_FORCE_,$force,g" -e"s,_ANC_,${anc},g" -e "s,_AFR_,${afr},g" -e "s,_OUTPUT_,$outputprefix,g" $plumedFile > $plumed_file
		
		sbatch -o ${outputprefix}.slurm.log --error=${outputprefix}.err --job-name=$full_label run-gpu-job.sbatch $outputprefix $ns $tpr $plumed_file 
	done
done
