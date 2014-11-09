#
#import data from csv
#get data into xyz pts

# for each of the muscles of interest, 
# 	get the surfaceval of that muscle
# 	run the interpolation and plot
#   set filename to the specimen, muscle and alpha
#   save the plot to pdf
from scipy.io import loadmat
from numpy.linalg import pinv
from numpy import matrix, diag
mat_data_struct = loadmat('/../C_13_13_16_18_19_20_21_23_25_30_27_5.mat')
mat_data_struct.keys()