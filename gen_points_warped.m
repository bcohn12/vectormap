function [ lon,lat ] = gen_points_warped( lat_n, lon_n )
%choose an even number for the sake of avoiding 0 vals
    lon = linspace(-180,180,lon_n);  
    lat = linspace(-90,90,lat_n);
end

