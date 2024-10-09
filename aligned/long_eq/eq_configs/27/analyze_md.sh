#!/bin/bash

echo "16 0" | gmx energy -f npt_short.edr -o temp_md.xvg
echo "17 0" | gmx energy -f npt_short.edr -o pressure_md.xvg
echo "23 0" | gmx energy -f npt_short.edr -o density_md.xvg
