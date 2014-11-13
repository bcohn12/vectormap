function [  ] = vectormap_2D(RFm, J, plane, n)
% @param RFm RFm matrix
% @param J Jacobian matrix
% @param n Number of vectors to be generated (uniformly) and evaluated
% @description 
[circle_x,circle_y] = gen_xy_circle(n);
switch plane
    case 'xy'
        task_vector_matrix=[circle_x, circle_y, zeros(n), %forces of xyz
                            zeros(n), zeros(n), zeros(n)] %torques of xyz
        
end

[ magnitude, activation_vec ] = get_magnitude_model_input( ...
	Fend, RFm, J)

end

