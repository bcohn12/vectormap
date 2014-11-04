from globe_transformations import *
import numpy as np
from mpl_toolkits.basemap import Basemap
import matplotlib.pyplot as plt
gen_txt = 'sample_generators.txt'
generators = np.loadtxt(gen_txt)
# create Basemap instance for Robinson projection.
m = Basemap(projection='robin', lon_0 = 0)
# make filled contour plot.
cartesian2latlon_matrix(generators)
cs = m.contourf(x,y,etopo,30,cmap=plt.cm.jet)
# draw parallels and meridians.
m.drawparallels(np.arange(-60.,90.,30.),labels=[1,0,0,0])
m.drawmeridians(np.arange(0.,360.,60.),labels=[0,0,0,1],fontsize=12)
m.colorbar(location='bottom',pad='5%')
# add a title.
plt.title('Robinson Projection')
plt.show()