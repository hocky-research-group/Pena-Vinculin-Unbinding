#module purge
#module load gromacs-plumed/openmpi/intel/2022.3

#---(2) generate configs----
for i in `seq 1 1 20`
do
	gmx grompp -f md_fes.mdp -c ${i}/md.gro -r ${i}/md.gro -t ${i}/md.cpt -n index.ndx -p topol.top -o md_fes${i}.tpr 
done
