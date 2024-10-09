#!/bin/bash
#SBATCH --time=24:00:00
#SBATCH --nodes=6
#SBATCH --mem=4096
#SBATCH --tasks-per-node 16
#SBATCH --cpus-per-task 1

module purge
module load gromacs-plumed/openmpi/intel/2022.3

tpr=$1
outprefix=$2
steps=$3

srun gmx_mpi mdrun -v -s $tpr -deffnm $outprefix -cpi $outprefix.cpt -nsteps $steps 
