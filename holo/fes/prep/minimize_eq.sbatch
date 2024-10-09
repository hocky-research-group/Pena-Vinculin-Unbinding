#!/bin/bash
#SBATCH --time=4:00:00
#SBATCH --nodes=2
#SBATCH --mem=4096
#SBATCH --tasks-per-node 8
#SBATCH --cpus-per-task 1
#SBATCH --job-name=holo_prep
#SBATCH --dependency=singleton

module purge
module load gromacs-plumed/openmpi/intel/2022.3

#---(1) minimize mobile atoms restraining heavy atoms----
gmx_mpi grompp -f em.mdp -c solv_ions.gro -r solv_ions.gro -p topol.top -o em.tpr
srun gmx_mpi mdrun -v -deffnm em
#---(2) generate configs----
for i in `seq 1 1 20`
do
        gmx_mpi grompp -f nvt.mdp -v -c em.gro -r em.gro -n index.ndx -p topol.top -o nvt${i}.tpr
done
