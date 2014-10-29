import numpy as np
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
def scatter_unitvectors(xs,ys,zs):
	fig = plt.figure()
	ax = fig.add_subplot(111, projection='3d')
	ax.scatter(xs, ys, zs)
	ax.set_xlabel('X')
	ax.set_ylabel('Y')
	ax.set_zlabel('Z')
	plt.show()

