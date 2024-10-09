module purge
module load gromacs-plumed/openmpi/intel/2022.3

#---(2) generate configs----
for i in `seq 1 1 20`
do
	gmx_mpi grompp -f npt_nose.mdp -c ${i}/npt.gro -r ${i}/npt.gro -t ${i}/npt.cpt -n index.ndx -p topol.top -o npt_nose${i}.tpr 
	#srun gmx_mpi mdrun -v -deffnm nvt_protein
done
