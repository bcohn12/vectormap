import numpy as np
import matplotlib.pyplot as plt
import mpl_toolkits.mplot3d.axes3d as axes3d
# http://stackoverflow.com/questions/15880367/python-uniform-distribution-of-points-on-4-dimensional-sphere
def random_dim_points(N=800, dim=3, scatterplot=False):
	"""
	@brief This function generates random unitvectors to cover the shape of a sphere in N dimensions. Radius is 1.
	@param N Integer, the number of vectors to generate
	@parm dim Integer, the number of dimensions to generate random data for
	@param scatterplot False by default- When true, it will display a scatterplot of points in 3D space.
	@return points A N by dim numpy.ndarray. Each row is a vector, columns 0,1,2 represent x,y,z
	"""
	norm = np.random.normal
	normal_deviates = norm(size=(dim, N))
	radius = np.sqrt((normal_deviates**2).sum(axis=0))
	points = normal_deviates/radius
	if scatterplot:
		fig, ax = plt.subplots(subplot_kw=dict(projection='3d'))
		ax.scatter(*points)
		ax.set_aspect('equal')
		plt.show()
	return points