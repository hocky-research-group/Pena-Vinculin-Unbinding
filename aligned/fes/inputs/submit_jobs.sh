#!/bin/bash

plumedFile=$1
ns=$2
data_dir= # output directory

#----Loop through forces----
for f in `seq -30.0 10.0 30.0`
do	
	echo $f
	for i in `seq 1 1 20`
	do
		echo $i
		tpr=md_fes_${i}.tpr # config tpr
		force=`echo "scale=10;$f*0.01439" | bc` # convert pN to kcal/molA
		label=$(basename $plumedFile |cut -f 1 -d '.')
		outputprefix=${data_dir}/${label}_pn_${f}/${i}/${i}_fes_pullVt
		full_label=$(basename $outputprefix)
		outdir=$(dirname $outputprefix)
		mkdir -p $outdir
		plumed_file=${outputprefix}.pull.dat
		sed -e "s,_FORCE_,$force,g"\
			-e "s,_OUTPUT_,$outputprefix,g"\
			-e "s,_VINC_,vinc_CA_${i}-apo.pdb,g"\
			-e "s,_A5CA_,a5_CA_${i}.pdb,g" $plumedFile > $plumed_file
		
		run_options="$outputprefix $ns $tpr $plumed_file"
		echo ${outputprefix}
		sbatch -o ${outputprefix}.slurm.log --error=${outputprefix}.err --job-name=$full_label run-gpu-job.sbatch $outputprefix $ns $tpr $plumed_file 
	done
done
