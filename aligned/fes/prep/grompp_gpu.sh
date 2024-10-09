#!/bin/bash

export NOMP=$SLURM_CPUS_PER_TASK
export NMPI=$SLURM_NTASKS

outdir=`pwd`

#---(2) generate configs----
for i in `seq 1 1 20`
do
	args="gmx grompp -f md_fes.mdp -c ${i}/npt.gro -r ${i}/npt.gro  -n index.ndx -p topol.top -o md_fes${i}-gpu.tpr" 
	singularity exec  -B $outdir:/container-output /scratch/wpc252/gpu-benchmark/gromacs_2023-2.sif /bin/bash -c "${args}"  
done
