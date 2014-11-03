import numpy as np

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
    cartesians = zeros(n, 3)
    for i in xrange(n):
        cartesians[i,:] = np.array(latlon2cartesian(*tuple(latlons[i,:])))
    return cartesians

def cartesian2latlon_matrix(cartesians):
    n,_ = cartesians.shape
    latlons = zeros(n, 3)
    for i in xrange(n):
        laltons[i,:] = np.array(cartesian2latlon(*tuple(cartesians[i,:])))
    return latlons
                                   
def cartesian2latlon(x,y,z):
    """
    returns (lat, lon) with lat in [0,pi] and lon in [0,2*pi]
    """
    lat = np.arccos(z)
    lon = np.arctan2(y,x)
    return lat, lon%(2*np.pi)

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