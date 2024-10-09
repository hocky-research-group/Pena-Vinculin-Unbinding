#!/bin/bash

inputFile=$1
force=$2
data_dir= #colvar directory
label=$(basename $inputFile |cut -f 1 -d '.')

for xtc in `seq 1 1 20`
do
	tpr=../../inputs/md_fes${xtc}-gpu.tpr
	outputprefix=${data_dir}/${label}_pn_${force}/${xtc}/${xtc}_fes_pullVt
        xtc=${outputprefix}.full.xtc
	echo "Force $force run $xtc "
	#!bin/bash
	args="echo -e "27" | gmx sasa -f ${xtc} -s ${tpr} -o ${outputprefix}.sasa_a3a5.xvg -n bsa_index.ndx
	 echo -e "32" | gmx sasa -f ${xtc} -s ${tpr} -o ${outputprefix}.sasa_vt_h2h5cte.xvg -n bsa_index.ndx
	 echo -e "33" | gmx sasa -f ${xtc} -s ${tpr} -o ${outputprefix}.sasa_a3a5vth2h5cte.xvg -n bsa_index.ndx
	 echo -e "29" | gmx sasa -f ${xtc} -s ${tpr} -o ${outputprefix}.sasa_vt_h2h5.xvg -n bsa_index.ndx
	 echo -e "30" | gmx sasa -f ${xtc} -s ${tpr} -o ${outputprefix}.sasa_a3a5vth2h5.xvg -n bsa_index.ndx"
	
	outdir=$(dirname ${outputprefix} )
	# args="bash get_sasa.sh"
	singularity exec -B $outdir:$outdir /home/wpc252/Desktop/gmx_docker/gromacs-singularity/gromacs_2023_plumed.sif /bin/bash -c "${args}"  

done
