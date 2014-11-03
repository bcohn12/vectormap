from mpl_toolkits.basemap import Basemap
import numpy as np
import matplotlib.pyplot as plt
import random
from globe_transformations import *
# read in topo data (on a regular lat/lon grid)
etopo=np.loadtxt('etopo20data.gz')
lons=np.loadtxt('etopo20lons.gz')
lats=np.loadtxt('etopo20lats.gz')

nlons = 1081
nlats = 540


a = n_latlon2cartesian_mat(nlats,nlons)
plot_unit_vectors(a)

latlons = cartesian2latlon_matrix(a)

lons = np.linspace(0, 360, nlons)
lats = np.linspace(-90, 90, nlats)

etopo1 = np.zeros((nlats,nlons))

# creae Basemap instance for Robinson projection.
print(0.5*(lons[0]+lons[-1]))
m = Basemap(projection='robin',lon_0=0.5*(lons[0]+lons[-1]))
# make filled contour plot.
x, y = m(*np.meshgrid(lons, lats))
cs = m.contourf(x,y,etopo,30,cmap=plt.cm.jet)
# draw parallels and meridians.
m.drawparallels(np.arange(-60.,90.,30.),labels=[1,0,0,0])
m.drawmeridians(np.arange(0.,360.,60.),labels=[0,0,0,1],fontsize=12)
m.colorbar(location='bottom',pad='5%')
# add a title.
plt.title('Robinson Projection')
plt.show()