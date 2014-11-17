
# coding: utf-8

# Okay, lets load all necessary files

# import libraries and load the data file

# In[101]:

import numpy as np
import pdb
import matplotlib
# matplotlib.use('Agg')
import pylab
from mpl_toolkits.basemap import Basemap
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
from spherepoint_pick import random_dim_points
import warnings
from scipy.io import loadmat
from matplotlib.backends.backend_pdf import PdfPages
from interp_non_grid_xyz import *


# In[102]:

def mat_muscle_index(muscle_num):
    return muscle_num+5
def save_baseplots_a_prog(C_mat, muscles_of_interest,
    alpha_vals, grid_shape, permutation_str):
    """
    @param permutation_str str "scaled" or "nonscaled" etc, for the filename

    """
    for muscle in muscles_of_interest:
        m_scale = "scaled" + ".pdf"
        for alpha in alpha_vals:
            print(alpha)
            mat = C_mat[1,alpha] #set to 1 to only select the lowerbound.
            muscle_vals = mat[:,mat_muscle_index(muscle)]
            plt = interp_nongrid_xyz(mat[:,0:3], muscle_vals, grid_shape)
            title_str = "basemap_m" + str(muscle) + m_scale + " alpha"+str( alpha*.1 + 0.5 ) + ".pdf"
            plt.clim(0,1)
    #       plt.suptitle(title_str, fontsize=14, fontweight='bold')
            plt.title(title_str)
            plt.savefig(title_str, bbox_inches='tight')
            plt.show()


        print(muscle)
    print('scaled finished')

# In[ ]:
grid_shape = (10,20)
C_normal = loadmat('../output/C_13_14_16_18_19_20_21_23_25_30_27_5.mat')
C_scaled = loadmat('../output/C_scaled_13_14_16_18_19_20_21_23_25_30_27_5.mat')
# muscles_of_interest = [5,13,14,16,18,19,20,21,23,25,27,30]
muscles_of_interest = [5]
alpha_vals = range(5)

save_baseplots_a_prog(C_normal['C'], muscles_of_interest, 
                        alpha_vals, grid_shape, 'normal')
pdb.set_trace()
save_baseplots_a_prog(C_scaled['C_scaled'], muscles_of_interest, 
                        alpha_vals, grid_shape ,'peroneus_scaled')



