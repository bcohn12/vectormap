function [ MAT ] = gen_vector_point_warped( lat_n, lon_n, plot)
%@param lat_n number of latitude intervals
%@param lon_n number of longitude intervals
%@param plot logical, by default false.
   [lon, lat] = gen_points_warped(lat_n, lon_n);
   [X,Y] = meshgrid(lon,lat);
   x = [];
   y = [];
   z = [];
   for i=1:(lat_n*lon_n)
       [x_current,y_current,z_current] = to_vector(Y(i), X(i), 1);
       x = [x,x_current];
       y = [y, y_current];
       z = [z, z_current];
   end
   MAT = [x;y;z]';
   if plot
       scatter3(MAT(:,1), MAT(:,2),MAT(:,3))
        % Create xlabel
        xlabel({'X'});
        % Create ylabel
        ylabel({'Y'});
        % Create zlabel
        zlabel({'Z'});
        % Create title
        title({'Evaluated vectors'});

   end
end