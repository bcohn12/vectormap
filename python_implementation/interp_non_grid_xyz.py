import numpy as np
import pdb
from mpl_toolkits.basemap import Basemap
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
from spherepoint_pick import random_dim_points

def cart2sph(x, y, z):
    dxy = np.sqrt(x**2 + y**2)
    r = np.sqrt(dxy**2 + z**2)
    theta = np.arctan2(y, x)
    phi = np.arctan2(z, dxy)
    theta, phi = np.rad2deg([theta, phi])
    return theta % 360, phi, r

def sph2cart(theta, phi, r=1):
    theta, phi = np.deg2rad([theta, phi])
    z = r * np.sin(phi)
    rcosphi = r * np.cos(phi)
    x = rcosphi * np.cos(theta)
    y = rcosphi * np.sin(theta)
    return x, y, z

def scatter_unitvectors(xs,ys,zs):
    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')
    ax.scatter(xs, ys, zs)
    ax.set_xlabel('X')
    ax.set_ylabel('Y')
    ax.set_zlabel('Z')
    plt.show()

# Experimental data
# ----------------------------------
vector_dimensions=6
fval_column_of_interest= 30
my_data = np.genfromtxt('../output/submax_activation_alpha90_lower_m29.csv', delimiter=',')
xyz_coords = my_data.T[0:3] # grab the first three columns of x y and z

# For example, in an x,y,z,t_x,t_y,t_z dataset, dimensions=6, so the other columns
# are shifted over by 6. Add 6 to the muscle/fval number.
surfaceval = my_data.T[vector_dimensions+fval_column_of_interest][0:100]
# ----------------------------------

# random data
n_samples = 100
pts = 1 - 2 * np.random.rand(n_samples, 3)
l = np.sqrt(np.sum(pts**2, axis=1))
pts = pts / l[:, np.newaxis]
# surfaceval = 150 * np.random.rand(n_samples)

xyz_val = pts.T

# naive IDW-like interpolation on regular grid
theta, phi, r = cart2sph(*xyz_val)
nrows, ncols = (90,180)
lon, lat = np.meshgrid(np.linspace(0,360,ncols), np.linspace(-90,90,nrows))
xgrid,ygrid,zgrid = sph2cart(lon,lat)
Ti = np.zeros_like(lon) #preallocate
for r in range(nrows):
    for c in range(ncols):
        #v is the unknown point at the grid intersection
        pdb.set_trace()
        v = np.array([xgrid[r,c], ygrid[r,c], zgrid[r,c]])
        # a vector containing all of the dotproducts
        dotprod_of_vectors= np.dot(pts,v) 
        # angs is a vectors of the angles between the unknown point and the
        # rest of the points.
        angs = np.arccos(dotprod_of_vectors) 
        idx = np.where(angs == 0)[0]
        if idx.any():
            # if the unknown point is at the exact location of the known point, 
            # assign it the same value
            Ti[r,c] = surfaceval[idx[0]] 
        else:
            # idw is an array containing all of the weights with all 100 recorded points
            sum_of_inv_squared_distances = sum(1 / angs**2)
            idw = (1 / angs**2) / sum_of_inv_squared_distances
            Ti[r,c] = np.sum(surfaceval * idw)

# set up map projection
map = Basemap(projection='ortho', lat_0=45, lon_0=15)
# draw lat/lon grid lines every 30 degrees.
map.drawmeridians(np.arange(0, 360, 30))
map.drawparallels(np.arange(-90, 90, 30))
# compute native map projection coordinates of lat/lon grid.
x, y = map(lon, lat)
# contour data over the map.
cs = map.contourf(x, y, Ti, 15)
plt.title('Contours of surfaceval')
plt.show()