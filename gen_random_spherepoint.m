function [ points ] = gen_random_spherepoint( n )
%outputs two vectors. Each row is a point
    points = [];
    for i = 1:n
        %choose random numbers between 0 and 1
        u = rand(1,1);
        v = rand(1,1);
        theta = 2*pi*u;
        phi = acos(2*v - 1);
        theta = theta*180/pi;
        phi = phi*180/pi;
        points = [points ; [theta, phi]];
    end

    

end

