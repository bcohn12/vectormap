function [ lon, lat] = to_degrees( theta, phi )
%converts from radians to degrees
lon = (theta*180)/pi;
lat = (phi*180)/pi;
end

