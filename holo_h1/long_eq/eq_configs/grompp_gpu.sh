#!/bin/bash

outdir=`pwd`
gmx_vm= # path to gmx

#---(1) generate production configs----
for i in `seq 21 1 50`
do
	args="gmx grompp -f md_fes.mdp -c ${i}/npt.gro -r configs/config_${i}_sys.pdb  -t ${i}/npt.cpt -n index.ndx -p topol.top -o md_fes_${i}_gpu_vrscale.tpr" 
	singularity exec  -B $outdir:/container-output /scratch/wpc252/gpu-benchmark/gromacs_2023_plumed.sif /bin/bash -c "${args}"  
done
