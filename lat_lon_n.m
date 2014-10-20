function [ lat_n, lon_n ] = lat_lon_n( n )
%creates a 2:1 ratio of lat to lon.
    lat_n = ceil((2.0*n)/3.0);
    lon_n = ceil(n/3.0);
    
    %Trim off longitude so the total is still equal to n.
    while lon_n + lat_n > n
        lon_n = lon_n - 1;
    end
end

