#!/bin/bash

plumedFile=$1

#----Loop through forces----
for force in `seq 0.0 10.0 0.0`
do
	sbatch utils/get_bias.sh" ${plumedFile}" ${force}
done	
