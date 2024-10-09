#!/bin/bash

plumedFile=$1
#----Loop through forces----
for force in `seq -30.0 10.0 -30.0`
do
	sbatch utils/get_bias.sbatch "${plumedFile}" ${force}  
done	
