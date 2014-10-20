%% task_vector_bounds: takes in a model, task direction and alpha.
% @output Activationbounds A 2xn_muscles database showing the 
% activation upper and lower bounds in order to meet alpha*fmax 
% for the task vector
% @param RFm matrix representing the output space
% @param J matrix representing the linear approximation of end effector motion
% @param Fend 6 element vector containing [x,y,z,t_x,t_y,t_z] direction.
function [lower_activation_vec,upper_activation_vec] = activations_vec_task_alpha(...
		RFm, J, Fend, alpha)
	% Initialize the activation vectors
	lower_activation_vec = [];
	upper_activation_vec = [];
	for muscle_i = 1:length(RFm) %maximize and minimize each muscle
		% record the activation bounds for each muscle for the given Fend.
		[lo, hi] = task_vector_bounds(RFm, J, Fend, alpha, muscle_i);
		%Tag on the next muscle's bound value
		lower_activation_vec = [lower_activation_vec , lo];
		upper_activation_vec = [upper_activation_vec , hi];
	end
end