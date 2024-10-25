#!/bin/bash

plumed=$1
# --timestep does not matter as a concatenation of all colvars is being reweighted
plumed driver --plumed ${plumed} --noatoms --kt 2.494339 --timestep 2
