#!/bin/bash

outdir=`pwd`
args="bash analyze_md.sh"

singularity exec -B $outdir:/container-output /scratch/wpc252/gpu-benchmark/gromacs_2023_plumed.sif /bin/bash -c "${args}"  
