#!/bin/bash

plumed=$1
# --timestep does not matter as concatenated colvars are being reweighted
plumed driver --plumed ${plumed} --noatoms --kt 2.494339 --timestep 2
