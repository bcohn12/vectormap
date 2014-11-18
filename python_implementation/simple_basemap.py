from mpl_toolkits.basemap import Basemap
import numpy as np
import matplotlib.pyplot as plt

def cart2sph(x, y, z):
    dxy = np.sqrt(x**2 + y**2)
    r = np.sqrt(dxy**2 + z**2)
    theta = np.arctan2(y, x)
    phi = np.arctan2(z, dxy)
    theta, phi = np.rad2deg([theta, phi])
    return theta % 360, phi, r

num_lons = 18
num_lats = 9

step_lons = 360. / num_lons
step_lats = 180. / num_lats

lons = np.linspace(-180., 180., num_lons)
lats = np.linspace( -90.,  90., num_lats)

data = np.reshape(np.arange(0, num_lons*num_lats), (num_lats, num_lons))

lons, lats = np.meshgrid(lons, lats)

print num_lons, len(lons)
print num_lats, len(lats)

fig = plt.figure()
ax = fig.add_axes([0.05,0.05,0.9,0.9])
m = Basemap(projection='ortho', lat_0=90, lon_0=-90, resolution=None)
im = m.pcolormesh(lons, lats, data, shading='flat', cmap=plt.cm.jet, latlon=True)
m.drawparallels(np.arange(-90.,99.,30.))
m.drawmeridians(np.arange(-180.,180.,60.))

# add x, y, z axis labels
axis_point_labels = ['+x', '+y', '+z']
axis_points = np.eye(3)
for i in range(3):
    lat, lon, r = cart2sph(*tuple(axis_points[:,i]))
    axis_proj_x, axis_proj_y = m(lat, lon)
    plt.plot(axis_proj_x, axis_proj_y, 'ro', zorder=10)
    plt.text(axis_proj_x, axis_proj_y, axis_point_labels[i], color='r', weight='bold', zorder=10)

cb = m.colorbar(im,"bottom", size="5%", pad="2%")
ax.set_title('m robin test')

plt.show()
