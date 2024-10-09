#!/bin/bash

outdir=`pwd`
gmx_vm= #path to gmx

#---(1) generate production configs----
for i in `seq 26 1 55`
do
	args="gmx grompp -f md_fes.mdp -c ${i}/npt_eqpr.gro -r ${i}/npt_eqpr.gro  -t ${i}/npt_eqpr.cpt -n index.ndx -p topol.top -o md_fes_${i}.tpr" 
	singularity exec  -B $outdir:/container-output /scratch/wpc252/gpu-benchmark/gromacs_2023_plumed.sif /bin/bash -c "${args}"  
done
