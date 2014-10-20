# terminal:  $ipython xyz_from_csv.py "output/jul11/sampled_fval_mat_cat1_pointnum_100000scaling1.csv"

from numpy import genfromtxt
import sys
from IPython.core.debugger import Tracer
import numpy as np
import random
from sage.all import *

def first_3_cols_of_csv(filename):
	"""
	takes in a csv
	outputs a numpy array that only returns the first three columns
	"""
	my_data = np.loadtxt(open(filename,"rb"),delimiter=",",skiprows=0,usecols = (0,1,2))
	print(my_data)
	return my_data

# def sample_n_rows(np_array, n):
# 	return(np.random.choice(np_array, n))



def get_volume(L):
    poly_3d_space = Polyhedron(vertices = L)
    vol = poly_3d_space.volume()
    return vol
    
def to_poly(L):
    poly_3d_space = Polyhedron(vertices = L)
    return poly_3d_space

def poly_plot(polygon):
    polygon.render_solid(opacity = .5)

def main():
	filename = sys.argv[1]
	allrows = first_3_cols_of_csv(filename)
	samp = random.sample(allrows, 2)
	newarr = np.array(samp)
	print(newarr)
	get_volume(newarr)
if __name__ == "__main__":
	main()


