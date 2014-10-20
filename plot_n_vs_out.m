function [ ] = plot_n_vs_out( resolution)
n_vals = linspace(1,10000,resolution);
product=[];
for e = 1:resolution
    [lat_n, lon_n] = lat_lon_n(n_vals(e));
    point_num = lat_n*lon_n;
    product = [product, point_num];
end

plot(n_vals,product)

end

