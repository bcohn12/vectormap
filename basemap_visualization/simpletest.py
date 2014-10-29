from mpl_toolkits.basemap import Basemap
import numpy as np
import matplotlib.pyplot as plt
import random
# read in topo data (on a regular lat/lon grid)
etopo=np.loadtxt('etopo20data.gz')
lons=np.loadtxt('etopo20lons.gz')
lats=np.loadtxt('etopo20lats.gz')

nlons = 200
nlats = 100

lons = np.linspace(0, 360, nlons)
lats = np.linspace(-90, 90, nlats)

etopo1 = np.zeros((nlats,nlons))

# creae Basemap instance for Robinson projection.
print(0.5*(lons[0]+lons[-1]))
m = Basemap(projection='robin',lon_0=0.5*(lons[0]+lons[-1]))
# make filled contour plot.
x, y = m(*np.meshgrid(lons, lats))
cs = m.contourf(x,y,etopo1,30,cmap=plt.cm.jet)
# draw parallels and meridians.
m.drawparallels(np.arange(-60.,90.,30.),labels=[1,0,0,0])
m.drawmeridians(np.arange(0.,360.,60.),labels=[0,0,0,1],fontsize=12)
m.colorbar(location='bottom',pad='5%')
# add a title.
plt.title('Robinson Projection')
plt.show()