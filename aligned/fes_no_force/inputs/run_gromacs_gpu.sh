#!/bin/bash
tprfile=$1
outprefix=$2
time_in_ns=$3
#gmxexe=$4
plumed_file=$4

if [ -z "$time_in_ns" ];then
echo "Usage: $0 tprfile outprefix time_in_ns (gmxexe)"
exit
fi

#set -x

if [ -z "$gmxexe" ];then
#    source /scratch/work/hockygroup/wpc252/software/gromacs2022-plumed2.8/bin/GMXRC.bash.modules
#    module purge
#    module load gromacs-plumed/openmpi/intel/2022.3
    export NOMP=$SLURM_CPUS_PER_TASK
    export NMPI=$SLURM_NTASKS
    gmxexe=gmx
fi


timestep=2 #fs
steps=$(echo $time_in_ns*1000000/$timestep |bc)
outdir=$(dirname $outprefix)
#mkdir -p $outdir

progressfile=$outprefix.progress.txt
# next line returns 0 even if file not found
prgtmp=$(cat $progressfile)
if [ -z "$prgtmp" ];then
    prevsteps=0
else
    prevsteps=$prgtmp
    extraflags="-noappend"
fi
#prevsteps=$(echo $(cat $progressfile)|bc) 
newsteps=$(($prevsteps+$steps))
outprefix_old=${outprefix}.run.$prevsteps
outprefix_new=${outprefix}.run.$newsteps

if [ "$prevsteps" -gt 0 ];then
    continuestring="-cpi $outprefix_old.cpt "
else
    continuestring=""
fi

if [ ! -z "$plumed_file" ];then
    plumedstring="-plumed $plumed_file"
fi

echo $NOMP "nomp"
echo $NMPI "nmpi"
echo "Launching gromacs....."

#args="gmx mdrun -ntomp $NOMP -nb gpu -s $tpr -deffnm  $outputprefix -nsteps 1000000 -plumed $plumed_file"
#args="gmx mdrun -ntomp $NOMP -pin on -pinstride 1 -nb gpu -pme gpu -bonded gpu -s md_v.tpr -deffnm md_v"
args="${gmxexe} mdrun ${extraflags} -ntomp ${NOMP} -pin on -pinstride 1 -nb gpu -pme gpu -bonded gpu -s ${tprfile} ${continuestring} -deffnm ${outprefix_new} -nsteps ${steps} ${plumedstring} && echo ${newsteps} > ${progressfile}"
singularity exec --nv -B ${outdir}:/container-output /scratch/wpc252/gpu-benchmark/gromacs_2023_plumed.sif /bin/bash -c "${args}"  
