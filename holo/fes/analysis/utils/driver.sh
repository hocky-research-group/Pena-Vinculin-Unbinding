#!/bin/bash

plumed=$1

plumed driver --plumed ${plumed} --noatoms --kt 2.494339 --timestep 40
