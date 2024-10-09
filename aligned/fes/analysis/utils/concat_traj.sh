#!/bin/bash

plumedFile=$1
data_dir=/media/wpc252/Expansion/greene_scratch/wpc252/project-4/actin-vinculin-prod

label=$(basename $plumedFile |cut -f 1 -d '.')
for run in `seq 1 1 20`
do
	for force in `seq -30.0 60.0 30.0`
	do
		outputprefix=${data_dir}/${label}_pn_${force}/${run}/${run}_fes_pullVt
		full_label=$(basename $outputprefix)
		outdir=$(dirname $outputprefix)
		xtc_arr=($(ls -rt ${outdir} | grep 'xtc$'))
		arr_l=${#xtc_arr[@]}
		if (( $(echo "${arr_l} < 2" | bc -l) ));
		then	
			traja=${outdir}/${xtc_arr[0]}
			mv ${traja} ${outputprefix}.full.xtc
			#echo ${traja}
		elif (( $(echo "${arr_l} == 2" | bc -l) ));
		then
			traja=${outdir}/${xtc_arr[0]}
			trajb=${outdir}/${xtc_arr[1]}
			#echo ${traja} ${trajb} 
			gmx_mpi trjcat -f ${traja} ${trajb} -o ${outputprefix}.full.xtc	
		else
			traj_str=${outdir}/${xtc_arr[0]}
			lindex=`echo "${arr_l} - 1" | bc`
			for trj in `seq 1 1 ${lindex}`
			do
				traj_str="${traj_str} ${outdir}/${xtc_arr[$trj]}"
			done
			echo ${traj_str}
			gmx_mpi trjcat -f ${traj_str} -o ${outputprefix}.full.xtc	
		fi

	done
done
