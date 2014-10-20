function [ MAT ] = random_surface_points( n )
% http://www.mathworks.com/help/matlab/math/numbers-placed-randomly-within-volume-of-sphere.html
% [1] Knuth, D. The Art of Computer Programming. Vol. 2, 3rd ed. Reading, MA: Addison-Wesley Longman, 1998, pp. 134?136.
    rvals = 2*rand(n,1)-1;
    elevation = asin(rvals);
    azimuth = 2*pi*rand(n,1);
    radii = 1*(rand(n,1).^(1/3));
    [x,y,z] = sph2cart(azimuth,elevation,1);
    % // figure
    % // plot3(x,y,z,'.');
    % // axis equal
    MAT = [x, y, z];
end

