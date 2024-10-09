#!/bin/bash

outdir=`pwd`
gmx_vm= #path to gmx
#---(1) generate configs----
for i in `seq 1 1 50`
do
        args="gmx grompp -f npt_eq_vrscale.mdp -c configs/config_${i}_sys.pdb -r configs/config_${i}_sys.pdb  -n index.ndx -p topol.top -o npt_config_${i}-gpu_vrescale.tpr"
        singularity exec  -B $outdir:/container-output ${gmx_vm}/gromacs_2023_plumed.sif /bin/bash -c "${args}"
done

