#!/bin/bash
#module load gromacs
gmx editconf -f actin_holoh1_nosol_aligned.pdb -o newbox.gro -c -d 1.0 -bt triclinic
gmx solvate -cp newbox.gro -cs spc216.gro -p topol.top -o solv.gro
gmx grompp -f ions.mdp -c solv.gro -p topol.top -o ions.tpr
echo -e "19" | gmx genion -s ions.tpr -o solv_ions.gro -p topol.top -conc .05 -neutral
