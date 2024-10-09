#!/bin/bash

plumedFile=$1

#----Loop through forces----
for force in `seq -30.0 10.0 30.0`
do
        bash utils/get_bias_force.sh "${plumedFile}" ${force} &
done
