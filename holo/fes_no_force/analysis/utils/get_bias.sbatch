#!/bin/bash
#SBATCH --time=6:00:00
#SBATCH --nodes=1
#SBATCH --mem=10GB
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=1

#module purge
#module load plumed/openmpi/intel/2.8.3

export NOMP=$SLURM_CPUS_PER_TASK
export NMPI=$SLURM_NTASKS

inputFile=$1
force=$2

data_dir=/scratch/wpc252/projects/project-4/actin-vinculin-prod
label=$(basename $inputFile |cut -f 1 -d '.')

for xtc in `seq 26 1 45`
	do
		trajprefix=${data_dir}/${label}_pn_${force}/${xtc}/${xtc}_fes_pullVt
	        outputprefix=${data_dir}/${label}_pn_${force}/${xtc}/${xtc}_fes_pullVt_rerun
	        traj=${trajprefix}.run.50000000.xtc
	        forcepN=`echo "scale=10;$force*0.01439" | bc` # convert pN to kcal/molA	
		for bias in `seq 26 1 45`
		do
			echo "Force $force run $xtc window $bias "
			input=${data_dir}/${label}_pn_${force}/${bias}/${bias}_fes_pullVt
			output=${outputprefix}_${bias}
			plumed_file=${outputprefix}_${bias}.dat
	
		sed -e "s,_FORCE_,${forcepN},g" -e "s,_INPUT_,$input,g" -e "s,_OUTPUT_,$output,g" -e "s,_TRAJ_,$trajprefix,g" $inputFile > $plumed_file
		bash utils/driver_rerun.sh ${plumed_file} ${traj}
		done
done
