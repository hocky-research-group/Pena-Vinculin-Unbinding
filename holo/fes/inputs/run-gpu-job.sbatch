#!/bin/bash
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --mem=10GB
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=24
#SBATCH --gres=gpu:1

outprefix=$1
#time in ns
run_time=$2
tprfile=$3
plumed=$4

bash run_gromacs_gpu.sh $tprfile $outprefix $run_time $plumed
