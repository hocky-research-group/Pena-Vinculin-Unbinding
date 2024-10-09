module purge
module load gromacs-plumed/openmpi/intel/2022.3

#---(2) generate tprs----
for i in `seq 1 1 20`
do
	gmx_mpi grompp -f npt.mdp -c ${i}/nvt.gro -r ${i}/nvt.gro -t ${i}/nvt.cpt -n index.ndx -p topol.top -o npt${i}.tpr -maxwarn 1
done
