
import numpy as np
from numpy import zeros
import scatter_unitvectors
from scatter_unitvectors import *
# We use the formulas from Wikipedia:
# 
# http://en.wikipedia.org/wiki/Spherical_coordinate_system#Cartesian_coordinates

def latlon2cartesian(lat, lon):
    """
    lat in [0,pi] is latitude (inclination)
    lon in [0,2*pi] is longitude (azimuth)
    """
    x = np.sin(lat) * np.cos(lon)
    y = np.sin(lat) * np.sin(lon)
    z = np.cos(lat)
    return x,y,z

def latlon2cartesian_matrix(latlons):
    n,_ = latlons.shape
    cartesians = np.zeros((n, 3))
    for i in xrange(n):
        cartesians[i,:] = np.array(latlon2cartesian(*tuple(latlons[i,:])))
    return cartesians

def cartesian2latlon_matrix(cartesians):
    n,_ = cartesians.shape
    latlons = np.zeros((n, 3))
    for i in xrange(n):
        latlons[i,:] = np.array(cartesian2latlon(*tuple(cartesians[i,:])))
    return latlons
                                   
def cartesian2latlon(x,y,z):
    """
    returns (lat, lon) with lat in [0,pi] and lon in [0,2*pi]
    """
    lat = np.arccos(z)
    lon = np.arctan2(y,x)
    return lat, lon%(2*np.pi)

def n_by_2_lonlat_mat(nlats,nlons):
    """you plug in the number of latitudes you want represented
    and the number of longitudes you want. It will linspace between
    those values to make a grid of size nLats*nlons
    
    returns a nlons*nlats by 2 matrix
    """
    lats = np.linspace(-90,90, nlats)
    lons = np.linspace(0, 360, nlons)
    mat_lats_lons = np.zeros((nlons*nlats,2))
    counter=0;
    for lon in lons:
        for lat in lats:
            # print('lon is ' + str(lon) + 'lat is ' + str(lat))
            mat_lats_lons[counter, 0] = lat
            mat_lats_lons[counter, 1] = lon
            counter+=1
    return mat_lats_lons

def n_latlon2cartesian_mat(nlats,nlons):
    tall_latlon_mat= n_by_2_lonlat_mat(nlats,nlons)
    print('computed tall latlon mat')
    cartesian_mat = latlon2cartesian_matrix(tall_latlon_mat)
    return cartesian_mat


def savetxt_of_vectors(plot=False):
    a = n_latlon2cartesian_mat(540,1081)
    if plot:
        plot_unit_vectors(a)
    np.savetxt('vectors.txt',a)

def plot_unit_vectors(a):
    """a[,0] is x, a[,1] is y, a[,2] is z
    """
    scatter_unitvectors(a[:,0],a[:,1],a[:,2])

def test(num_tests=10000, tol=1e-6):
    cartesians = np.random.rand(num_tests,3)
    for t in range(num_tests):
        cartesians[t,:] /= np.linalg.norm(cartesians[t,:])

    for t in range(num_tests):
        p = cartesians[t,:]
        p = tuple(p)
        q = latlon2cartesian(*cartesian2latlon(*p))
        diff = np.array(p) - np.array(q)
        dist = np.linalg.norm(diff)
        if dist >= tol:
            print p
            print q
            print diff
            print ""

    latlons = np.random.rand(num_tests, 2)
    latlons[:,0] *= np.pi
    latlons[:,1] *= 2.0*np.pi
    for t in range(num_tests):
        a = tuple(latlons[t,:])
        b = cartesian2latlon(*latlon2cartesian(*a))
        diff = np.array(a) - np.array(b)
        dist = np.linalg.norm(diff)
        if dist >= tol:
            print a
            print b
            print ""

if __name__ == '__main__':
    test()