#!/bin/bash

export NOMP=$SLURM_CPUS_PER_TASK
export NMPI=$SLURM_NTASKS

#tpr=$1
#outputprefix=$2
#plumed_file=$3
#args="gmx_mpi grompp -f md_fes.mdp -c ${i}/md.gro -r ${i}/md.gro  -n index.ndx -p topol.top -o md_fes${i}-gpu.tpr" 
#args="gmx mdrun -ntomp $NOMP -nb gpu -s $tpr -deffnm  $outputprefix -nsteps 1000000 -plumed $plumed_file"
outdir=`pwd`

#singularity exec --nv -B $outdir:/container-output /scratch/wpc252/gpu-benchmark/gromacs_2023-2.sif /bin/bash -c "${args}"  
#---(2) generate configs----
for i in `seq 1 1 20`
do
	args="gmx grompp -f md_fes.mdp -c ${i}/md.gro -r ${i}/md.gro  -n index.ndx -p topol.top -o md_fes${i}-gpu.tpr" 
	singularity exec --nv -B $outdir:/container-output /scratch/wpc252/gpu-benchmark/gromacs_2023-2.sif /bin/bash -c "${args}"  
	#gmx_mpi grompp -f md_fes.mdp -c ${i}/md.gro -r ${i}/md.gro  -n index.ndx -p topol.top -o md_fes${i}-gpu.tpr 
done
