import numpy as np
import pdb
from mpl_toolkits.basemap import Basemap
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
from spherepoint_pick import random_dim_points
import warnings

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

def interp_nongrid_xyz(pts, surfaceval):
    """
    @param pts an N by 3 numpy array containing the unitvectors.
    @param surfaceval an N-lengthed numpy array containing the values for each 
    """
    # naive IDW-like interpolation on regular grid
    theta, phi, r = cart2sph(*pts.T)
    nrows, ncols = (180,360)
    lon, lat = np.meshgrid(np.linspace(0,360,ncols), np.linspace(-90,90,nrows))
    xgrid,ygrid,zgrid = sph2cart(lon,lat)
    Ti = np.zeros_like(lon) #preallocate
    for r in range(nrows):
        for c in range(ncols):
            #v is the unknown point at the grid intersection
            v = np.array([xgrid[r,c], ygrid[r,c], zgrid[r,c]])
            # a vector containing all of the dotproducts
            norm_pts = np.linalg.norm(pts, axis=1)
            norm_v = np.linalg.norm(v)
            dotprod_normalizer = norm_pts * norm_v
            dotprod_normalizer[dotprod_normalizer == 0] = 1
            dotprod_of_vectors= np.dot(pts,v) / dotprod_normalizer
            # angs is a vectors of the angles between the unknown point and the
            # rest of the points.
            # pdb.set_trace()
            # print repr(dotprod_of_vectors)
            if 1 in dotprod_of_vectors>1:
                print('TOO BIG')
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

    # set up sphere_map projection
    sphere_map = Basemap(projection='ortho', lat_0=45, lon_0=15)
    # draw lat/lon grid lines every 30 degrees.
    sphere_map.drawmeridians(np.arange(0, 360, 30))
    sphere_map.drawparallels(np.arange(-90, 90, 30))
    # compute native sphere_map projection coordinates of lat/lon grid.
    x, y = sphere_map(lon, lat)
    # contour data over the sphere_map.
    cs = sphere_map.contourf(x, y, Ti, 15)
    
    # add axis points and labels
    axis_vectors = np.eye(3)
    axis_labels = ['+x', '+y', '+z']
    for i in range(3):
        lat, lon, r = cart2sph(*tuple(axis_vectors[:,i]))
        axis_proj_x, axis_proj_y = sphere_map(lat, lon)
        plt.plot(axis_proj_x, axis_proj_y, 'ro', zorder=10)
        plt.text(axis_proj_x, axis_proj_y, axis_labels[i], color='r', weight='bold', zorder=10)

    plt.title('Contours of surfaceval')
    plt.show()
    return x,y,Ti

def test_xyz_activation_data():
    vector_dimensions=6
    fval_column_of_interest= 29
    my_data = np.genfromtxt('../output/submax_activation_alpha90_lower_m29.csv', delimiter=',')
    pts = my_data.T[0:3].T
    # Subtract  one so we can get the indicies correct
    # For example, in an x,y,z,t_x,t_y,t_z dataset, dimensions=6, so the other columns
    # are shifted over by 6. Add 6 to the muscle/fval number. SUbtract 1 because the first
    # element is the 0th element.
    column_to_extract = vector_dimensions + fval_column_of_interest - 1
    surfaceval = surfaceval = my_data.T[column_to_extract]
    return pts, surfaceval

def test_xyz_fval():
    vector_dimensions=6
    fval_column_of_interest= 29
    my_data = np.genfromtxt('../output/sampled_fval_mat_cat1_pointnum_10000scaling0.9.csv', delimiter=',')
    pts = my_data.T[0:3].T
    surfaceval = surfaceval = my_data.T[8]
    return pts, surfaceval


def main():
    # Experimental testing
    # ----------------------------------
    pts, surfaceval = test_xyz_activation_data()
    x,y,Ti = interp_nongrid_xyz(pts,surfaceval)
    pts, surfaceval = test_xyz_fval()
    x,y,Ti = interp_nongrid_xyz(pts,surfaceval)
    return Ti

if __name__ == '__main__':
    main()


