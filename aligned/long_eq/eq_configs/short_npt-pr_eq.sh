#!/bin/bash

outdir=`pwd`
gmx_vm=/scratch/work/hockygroup/wpc252/software
for i in `seq 26 1 55`
do
	args="gmx grompp -f npt_eqpr_vrscale.mdp -c ${i}/npt.gro -r configs/config_${i}_sys.pdb  -t ${i}/npt.cpt -n index.ndx -p topol.top -o npt_eqpr_${i}.tpr" 
        singularity exec  -B $outdir:/container-output ${gmx_vm}/gromacs_2023_plumed.sif /bin/bash -c "${args}"
done

