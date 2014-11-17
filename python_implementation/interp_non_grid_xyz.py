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

def cmap_bound_coloring(threshold=1e-1, vmin=0,vmax=1): 
    """
    @param threshold float Value which will define how much more than the min, and less than the max will be colored
    @param vmin float minimum value to color
    @param vmax float maximum value to color"""
    threshold = 1e-1
    vmin=vmin+threshold
    vmax=vmax-threshold
    debug = False # use debug colors for threshold value
    if debug:
        cmap = plt.cm.get_cmap('hot')
        cmap.set_under('white')
        cmap.set_over('green')
    else:
        cmap = plt.cm.get_cmap('PuOr')
        cmap.set_under('darkgrey') # FIXME
        cmap.set_over('white')    # FIXME
    return cmap, vmin, vmax

def xyz_basemap_labels(plt, labels = ['+x','+y','+z'], color='r'):
    """
    add axis points and labels
    @param plt A matplotlib plot object
    @param labels A three element list of strings, one for each axis.
    @return plt plot object with labels added
    """
    axis_vectors = np.eye(3) #generate unit vectors in each axis
    for i in range(3):
        lat, lon, r = cart2sph(*tuple(axis_vectors[:,i]))
        axis_proj_x, axis_proj_y = sphere_map(lat, lon)
        plt.plot(axis_proj_x, axis_proj_y, 'ro', zorder=10)
        plt.text(axis_proj_x, axis_proj_y, labels[i], 
            color='r', weight='bold', zorder=10)
    return plt

def interp_nongrid_xyz(pts, surfaceval, grid_shape=(180,360), cmap_bounds=False, my_lat_0=15, my_lon_0=15):
    """
    @param pts an N by 3 numpy array containing the unitvectors.
    @param surfaceval an N-lengthed numpy array containing the values for each 
    @TODO clean up subparts into smaller, reusable functions
    """
    # naive IDW-like interpolation on regular grid
    #rotate data so y is up, z is towards you, and x is to the right.
    # pdb.set_trace()
    vert_cols = pts.T
    #NOTE cols are imported ZXY so orientation is correct
    data_x = vert_cols[:,2]
    data_y = vert_cols[:,0]
    data_z = vert_cols[:,1]

    theta, phi, r = cart2sph(data_x,data_y,data_z)
    nrows, ncols = grid_shape
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
    sphere_map = Basemap(projection='ortho', lat_0=my_lat_0, lon_0=my_lon_0)
    # draw lat/lon grid lines every 30 degrees.
    sphere_map.drawmeridians(np.arange(0, 360, 30))
    sphere_map.drawparallels(np.arange(-90, 90, 30))
    # compute native sphere_map projection coordinates of lat/lon grid.
    x, y = sphere_map(lon, lat)
    #only color the bounds if specified (fval force vectormaps shouldn't have bounds)
    if cmap_bounds:
        cmap, vmin, vmax = cmap_bound_coloring() #color the bounds at top and bottom
        cs = sphere_map.contourf(x, y, Ti, 15, cmap=cmap, extend='both',
                                 vmin=vmin, vmax=vmax)
    else: 
        cmap = plt.cm.get_cmap('PuOr') #naIve coloring
        cs = sphere_map.contourf(x, y, Ti, 15, cmap=cmap, extend='both')
    

    # add axis points and labels
    axis_vectors = np.eye(3) #generate unit vectors in each axis
    axis_labels = ['+z', '+x', '+y'] #NOTE vector input is ZXY so it's oriented correctly
    for i in range(3):
        lat, lon, r = cart2sph(*tuple(axis_vectors[:,i]))
        axis_proj_x, axis_proj_y = sphere_map(lat, lon)
        plt.plot(axis_proj_x, axis_proj_y, 'ro', zorder=10)
        plt.text(axis_proj_x, axis_proj_y, axis_labels[i], 
            color='r', weight='bold', zorder=10)
    sphere_map.colorbar(location='bottom',pad='5%')
    return plt

def test_xyz_activation_data(muscle_num):
    vector_dimensions=6
    fval_column_of_interest= muscle_num
    my_data = np.genfromtxt('../output/submax_activation_alpha90_lower_m29.csv', delimiter=',')
    pts = my_data.T[0:3].T
    # Subtract  one so we can get the indicies correct
    # For example, in an x,y,z,t_x,t_y,t_z dataset, dimensions=6, so the other columns
    # are shifted over by 6. Add 6 to the muscle/fval number. SUbtract 1 because the first
    # element is the 0th element.
    column_to_extract = vector_dimensions + fval_column_of_interest - 1
    surfaceval = surfaceval = my_data.T[column_to_extract]
    return pts, surfaceval
def test_xyz_unscaled_alpha90_lower(muscle=13):
    C_normal = loadmat('../output/C_13_14_16_18_19_20_21_23_25_30_27_5.mat')
    mat = C_normal['C'][1,4]
    def mat_muscle_index(muscle_num):
        return muscle_num+5
    muscle_vals = mat[:,mat_muscle_index(muscle)]
    pltobj = interp_nongrid_xyz(mat[:,0:3], muscle_vals, (10,20))
    print(muscle_vals)
    return pltobj
def test_fval_matrix(col):
    vector_dimensions=6
    fval_column_of_interest= 29
    my_data = np.genfromtxt('../output/sampled_fval_mat_cat1_pointnum_10000scaling1.csv', delimiter=',')
    pts = my_data.T[0:3].T
    surfaceval = surfaceval = my_data.T[col]
   
    return pts, surfaceval


def test_fval(col, grid_resolution='lo'):
    """
    @param grid_resolution lo, med or hi. lo is a very fast implementation, hi takes a while.
    """
    # Experimental testing ----------------------------------
    # pts, surfaceval = test_xyz_activation_data()
    # x,y,Ti = interp_nongrid_xyz(pts,surfaceval)
    def resolution_case(x):
        return {'hi': (180,360),
                'med': (90,180),
                'lo': (10,20)
                        }[x]
    grid_shape = resolution_case(grid_resolution)            
    pts, surfaceval = test_fval_matrix(col)
    plt =  interp_nongrid_xyz(pts,surfaceval, grid_shape)
    plt.show()
    return pts



def test_alpha_activation(muscle_num=29, grid_resolution='lo'):
    """
    @param grid_resolution lo, med or hi. lo is a very fast implementation, hi takes a while.
    """
    # Experimental testing ----------------------------------
    pts, surfaceval = test_xyz_activation_data(muscle_num)

    def resolution_case(x):
        return {'hi': (180,360),
                'med': (90,180),
                'lo': (10,20)
                        }[x]
    grid_shape = resolution_case(grid_resolution)
    plt =  interp_nongrid_xyz(pts,surfaceval, grid_shape)
    plt.show()
    return pts