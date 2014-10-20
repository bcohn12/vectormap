function [ theta, phi ] = vector_2_spherical( xyz_vec )
    %takes in a vector with the first three elements [x,y,z]
    x = xyz_vec(1);
    y = xyz_vec(2);
    z = xyz_vec(3);
    r = sqrt(x^2 + y^2 + z^2);
    theta = acos(z/r); %this is longitude in radian units
    phi = atan(y/x); %this is latitude in radian units
end

