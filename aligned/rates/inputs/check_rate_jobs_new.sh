#!/bin/bash

plumedFile=$1
ns=$2
output=$3

data_dir= # output directory
timestep=2 #fs
steps=$(echo $ns*1000000/$timestep |bc)
simtimelimit=$(echo $ns*1000000 |bc)

label=$(basename $plumedFile |cut -f 1 -d '.')
c=0
d=0

for f in `seq -40.0 10.0 40.0`
do
        for i in `seq 26 1 45`
        do
	echo "+++ force $f run $i +++"
	outputprefix=${data_dir}/${label}_pn_${f}/${i}/${i}_rate_pullVt
	full_label=$(basename $outputprefix)
	outdir=$(dirname $outputprefix)
	last_cv_t=$(tail -n 1 ${outputprefix}.colvar.out | awk '{print $1}')
	last_cv_line=$(tail -n 1 ${outputprefix}.colvar.out)
	err_file="${outputprefix}.err"
        echo "${outputprefix}"	

	log_arr=($(ls -rt ${outputprefix}.run.*.log))
	if [ ! -z "${log_arr}" ]
	then
        	arr_l=${#log_arr[@]}
		lindex=`echo "${arr_l} - 1" | bc`
		log_file=${log_arr[$lindex]}
	else
		log_file=${outputprefix}.run.$steps.log
	fi
	echo $log_file

	if [ -z "${last_cv_t}" ];
	then
		echo $f $i "----- Failed to start ----"
                echo $f $i >> ${output}_failed.dat
                c=`echo "$c + 1" | bc`
	else

		if (( $(echo "${last_cv_t} < ${simtimelimit} " | bc -l) ));
		then
			lline=$(tail -n 1 ${outputprefix}.colvar.out)
	
			if [ -f "${log_file}" ];
			then
	        		errmsgb=`grep "Fatal"  ${err_file}`
				errmsgc=`grep "PLUMED error"  ${err_file}`
	        		errmsg=`grep "CANCELLED"  ${err_file} | head -n 1 | awk '{print $8}'`
	        		commit=`grep "COMMITTED"  ${log_file} | head -n 1 | awk '{print $3}'`
				finished=`grep "Finished mdrun"  ${log_file} | head -n 1 | awk '{print $1}'`
				cpt_steps=$(basename ${log_file} | cut -f 3 -d '.')	
	
				if [ -n "$errmsgc" ];
				then
	        			echo $f $i "----- Fatal -----"
					echo $f $i >> ${output}_failed.dat
					c=`echo "$c + 1" | bc`
				
				elif [ "$errmsg" == "CANCELLED" ];
	        		then
	        			echo $f $i "----- $errmsg -----"
	        	        	last=`grep 'Writing checkpoint' ${log_file} | tail -n 1 | awk '{print $4}'`
			#		cp ${outputprefix}.run.${cpt_steps}.cpt ${outputprefix}.run.$last.cpt
					remain=`echo "scale=6;(${steps} - $last)*2/1000000" | bc`
					echo $f $i $last $remain >> ${output}_notfinished.dat
				#	echo $last > ${outputprefix}.progress.txt
					d=`echo "$d + 1" | bc`
	
				elif [ "$commit" == "COMMITTED" ];
				then
					echo $f $i "+++++ $commit +++++"
					echo $f $i >> ${output}_committed.dat
					echo ${lline} >> ${output}_unbound.dat	
	
				elif [ "$finished" == "Finished" ];
				then
					echo $f $i "====== $finished ======"
	        	        	last=`grep 'Writing checkpoint' ${log_file} | tail -n 1 | awk '{print $4}'`
					remain=`echo "scale=6;(${steps} - $last)*2/1000000" | bc`
					echo $f $i $last $remain >> ${output}_finished.dat
							
				elif [ -n "$errmsgb" ];
				then
	        			echo $f $i "----- Fatal -----"
					echo $f $i >> ${output}_failed.dat
	        	                c=`echo "$c + 1" | bc`
				else
	        			echo $f $i "----- weird fail -----"
					echo $f $i >> ${output}_weirdfailed.dat
	        	                c=`echo "$c + 1" | bc`
	
				fi
			else			
				echo $f $i "----- Failed to start ----"
				echo $f $i >> ${output}_failed.dat
				c=`echo "$c + 1" | bc`
			fi
		else
			echo "at ${ns} ns"
			finished=`grep "Finished mdrun"  ${log_file} | head -n 1 | awk '{print $1}'`
			if [ "$finished" == "Finished" ];
	        	then
	        	 	echo $f $i "====== $finished ======"
	        	        echo $f $i >> ${output}_finished_${ns}.dat
				echo ${last_cv_line} >> ${output}_last_cv_${ns}.dat
	        	fi
		fi
	fi
	
	done
done
echo "total fail $c"
echo "total not finished $d"
