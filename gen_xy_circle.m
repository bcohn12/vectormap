function [x_list,y_list] = gen_xy_circle(n)
% @param n Number of samples around the circle (number of thetas to choose)
% @return x_list vector of x coordinates
% @return y_list vector of y coordinates
% @example [circle_x,circle_y] = gen_xy_circle(800); plot(circle_x,circle_y)
    r = 1;
    x_list = [];
    y_list = [];
    %iterate from 0 to 2pi
    for theta = linspace(0,2*pi, n)
        %calculate what the x and y coordinates are based on theta
        x = cos(theta);
        y = sin(theta);
        %add entries to the lists
        x_list = [x_list; x];
        y_list = [y_list; y];
    end
end