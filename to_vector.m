function [ x,y,z ] = to_vector( lat, lon, R )
    x = R .* cos(lat) .* cos(lon);
    y = R .* cos(lat) .* sin(lon);
    z = R .* sin(lat);
end

