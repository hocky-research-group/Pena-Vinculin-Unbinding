#!/bin/bash

label=${1}
ns=${2}

data_dir=.
timestep=2 #fs
for i in `seq 1 1 20`
do
        mkdir -p ${data_dir}/${i}

	steps=$(echo $ns*1000000/$timestep |bc)
	tpr=${label}${i}.tpr
	outputprefix=${data_dir}/${i}/${label}
        full_label=${i}$(basename $outputprefix)
        outdir=$(dirname $outputprefix)

	echo $tpr $outputprefix $steps
	sbatch -o ${outputprefix}.slurm.log --error=${outputprefix}.err --job-name=$full_label equilibrate.sbatch $tpr $outputprefix $steps

done
