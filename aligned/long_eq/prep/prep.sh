#!/bin/bash
#module load gromacs
gmx_mpi editconf -f actin_apom_nosol_aligned.pdb -o newbox.gro -c -d 1.0 -bt triclinic
gmx_mpi solvate -cp newbox.gro -cs spc216.gro -p topol.top -o solv.gro
gmx_mpi grompp -f ions.mdp -c solv.gro -p topol.top -o ions.tpr
echo -e "19" | gmx_mpi genion -s ions.tpr -o solv_ions.gro -p topol.top -conc .05 -neutral
