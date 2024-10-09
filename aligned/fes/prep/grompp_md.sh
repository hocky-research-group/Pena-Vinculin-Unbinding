module purge
module load gromacs-plumed/openmpi/intel/2022.3

#---(2) generate configs----
for i in `seq 1 1 20`
do
	gmx_mpi grompp -f md.mdp -c ${i}/npt_nose.gro -r ${i}/npt_nose.gro -t ${i}/npt_nose.cpt -n index.ndx -p topol.top -o md${i}.tpr -maxwarn 1
	#srun gmx_mpi mdrun -v -deffnm nvt_protein
done
