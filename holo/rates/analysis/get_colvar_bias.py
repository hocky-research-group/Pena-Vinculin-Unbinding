import numpy as np
import sys

cvfile=sys.argv[1]
biasfile=sys.argv[2]
output=str(sys.argv[3])

# Read colvar and bias files
cv_data = np.genfromtxt(cvfile, dtype=float, usecols=(0,1,2,7), comments='#') # read time,proj,ext,cmap
bias_data = np.genfromtxt(biasfile, dtype=float, comments='#')

# append bias column to colvar columns and write to output file
out_data = np.hstack((cv_data,np.reshape(bias_data[:,1],(-1,1))))
np.savetxt(output, out_data, delimiter = '  ', newline='\n', header='FIELDS time proj ext cmap opes.bias', comments='#! ')
