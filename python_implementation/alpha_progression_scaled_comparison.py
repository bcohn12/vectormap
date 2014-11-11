
# coding: utf-8

# Okay, lets load all necessary files

# import libraries and load the data file

# In[101]:

import numpy as np
import pdb
import matplotlib
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


# In[ ]:

C_normal = loadmat('../output/C_13_14_16_18_19_20_21_23_25_30_27_5.mat')
muscles_of_interest = [5,13,14,16,18,19,20,21,23,25,27,30]
alpha_vals = range(5)


# In[ ]:

for muscle in muscles_of_interest:
    m_scale = "m" + str(muscle) + "nonscaled" + ".pdf"
    for alpha in alpha_vals:
        print(alpha)
        mat = C_normal['C'][1,alpha] #set to 1 to only select the lowerbound.
        muscle_vals = mat[:,mat_muscle_index(muscle)]
        plt = interp_nongrid_xyz(mat[:,0:3], muscle_vals)
        title_str = "alpha is"+str( alpha*.1 + 0.5 ) + " m" + str(muscle) + m_scale
        plt.clim(0,1)
#         plt.suptitle(title_str, fontsize=14, fontweight='bold')
        plt.title(title_str)
        plt.savefig(title_str, bbox_inches='tight')

    print(muscle)
print('nonscaled finished')
C_normal = loadmat('../output/C_scaled_13_14_16_18_19_20_21_23_25_30_27_5.mat')

for muscle in muscles_of_interest:
    m_scale = "m" + str(muscle) + "scaled" + ".pdf"
    for alpha in alpha_vals:
        print(alpha)
        mat = C_normal['C'][1,alpha] #set to 1 to only select the lowerbound.
        muscle_vals = mat[:,mat_muscle_index(muscle)]
        plt = interp_nongrid_xyz(mat[:,0:3], muscle_vals)
        title_str = "alpha is"+str( alpha*.1 + 0.5 ) + " m" + str(muscle) + m_scale
        plt.clim(0,1)
        plt.title(title_str)
        plt.savefig(title_str, bbox_inches='tight')
    print('newmuscle--------------' + muscle)

        


# for each of the muscles of interest, 
# get the surfaceval of that muscle
# run the interpolation and plot
#    set m_scale to the specimen, muscle and alpha
#    save the plot to pdf

# In[ ]:

ls


# In[ ]:




# In[ ]:




# In[ ]:




# In[ ]:




# In[ ]:




# In[ ]:




# In[ ]:



