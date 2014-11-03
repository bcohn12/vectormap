from mpl_toolkits.basemap import Basemap
import numpy as np
import matplotlib.pyplot as plt
import random
from globe_transformations import *
from matplotlib.mlab import griddata

# More Info: http://davydany.com/post/32287214449/matplotlibs-basemap-plotting-a-list-of-latitude
def show_map(a):

    # 'a' is of the format [(lats, lons, data), (lats, lons, data)... (lats, lons, data)]
    lats = [ x[0] for x in a ]
    lons = [ x[1] for x in a ]
    data = [ x[2] for x in a ]
     
    lat_min = min(lats)
    lat_max = max(lats)
    lon_min = min(lons)
    lon_max = max(lons)
    data_min = min(data)
    data_max = max(data)

    spatial_resolution = 0.5
    fig = plt.figure()

    x = np.array(lons)
    y = np.array(lats)
    z = np.array(data)
   
    xinum = (lon_max - lon_min) / spatial_resolution
    yinum = (lat_max - lat_min) / spatial_resolution
    xi = np.linspace(lon_min, lon_max + spatial_resolution, xinum)        # same as [lon_min:spatial_resolution:lon_max] in matlab
    yi = np.linspace(lat_min, lat_max + spatial_resolution, yinum)        # same as [lat_min:spatial_resolution:lat_max] in matlab
    xi, yi = np.meshgrid(xi, yi)
   
    zi = griddata(x, y, z, xi, yi)
   
    m = Basemap(
        projection = 'merc',
        llcrnrlat=lat_min, urcrnrlat=lat_max,
        llcrnrlon=lon_min, urcrnrlon=lon_max,
        rsphere=6371200., resolution='l', area_thresh=10000
    )
   
    m.drawcoastlines()
    m.drawstates()
    m.drawcountries()
   
    lat, lon = m.makegrid(zi.shape[1], zi.shape[0])
    x,y = m(lat, lon)
    m.contourf(x, y, zi)
   
    plt.show()
def test():
	# read in topo data (on a regular lat/lon grid)
	etopo=np.loadtxt('etopo20data.gz')
	lons=np.loadtxt('etopo20lons.gz')
	lats=np.loadtxt('etopo20lats.gz')

	nlons = 40
	nlats = 20
	mat = np.zeros((nlons*nlats, 3))
	for lat in range(nlats):
		for lon in range(nlons):
			mat[lat+lon][0] = lats[lat*10]
			mat[lat+lon][1] = lons[lon*10]
			mat[lat+lon][2] = etopo[lat*10][lon*10]
	show_map(mat)
