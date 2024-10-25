# Direct computational assessment of vinculin-actin unbinding kinetics reveals catch bonding behavior
[//]: # (Badges)
[![Static Badge](https://img.shields.io/badge/DOI-10.1101%2F2024.10.10.617580-red)]( https://doi.org/10.1101/2024.10.10.617580)
## Table of contents
* [Description](#Description)
* [Directories](#Directories)
* [Molinfo](#Residue-Info-for-models-of-Vt)

## Description
This repository contains inputs for simulations performed in the manuscript titled "A direct computational assessment of vinculin-actin unbinding kinetics reveals catch bonding behavior". 

All relevant files for the simulations of the models described in the main text can be found in the apropiate directories. Sample analysis code to compute FESs are included in the `fes_no_force/analysis` directory of each model, code to compute unbinding lifetimes are included in the `rates/analysis` directory of each model. Furthermore, code to generate figures in the main text is also included.
## Directories
The directories in this repo are described below.

both `holo` and `aligned` directories contain the following:
- bsa
- fes
- fes_no_force
- long_eq
- rates

`figures_ms`: contains notebook that was used to generate FES and rates figures, notebook reads data from outputs directory of each model

## Residue Info for models of Vt 

`holo`: 
- hVt: residue_ids 981 to 1131 (151 total) (index 29356 to 31745)
- H2_H5: residue_ids 981 to 1120 (29356 to 31546)
- H1: NONE

`aligned`: 
- aVt: residue_ids 882 to 1061 (180 total) (index 29356 to 32208)
- H2_H5: residue_ids 913 to 1052 (29849 to 32037)
- H1: residue_ids 882 to 912 (29356 to 29848)
  

`holo_h1`: 
- hh1Vt:residue_ids 882 to 912,981 to 1131 (182 total) (29356 to 32236)
- H2H5: residue_ids 981 to 1120  (29849 to 32037)
- H1: residue 882 to 912 (label) (29356 to 29848)
  