%% task_vector_bounds: takes in a model, task direction and alpha.
% @output Activationbounds A 2xn_muscles database showing the 
% activation upper and lower bounds in order to meet alpha*fmax 
% for the task vector. Other muscles not in the muscles_of_interest will
% have their activations set to -1 (essentially a NULL placeholder so the
% columns line up
% @param RFm matrix representing the output space
% @param J matrix representing the linear approximation of end effector motion
% @param Fend 6 element vector containing [x,y,z,t_x,t_y,t_z] direction.
% @param muscles_of_interest vector of integers representing muscle numbers
function [lower_activation_vec,upper_activation_vec] = ...
	activations_vec_task_alpha(...
		RFm, J, Fend, alpha, muscles_of_interest)
	% Initialize the activation vectors
	lower_activation_vec = [];
	upper_activation_vec = [];
	for muscle_i = 1:length(RFm) %maximize and minimize each muscle
	% record the activation bounds for each muscle for the given Fend.
		if ismember(muscle_i, muscles_of_interest)
			[lo, hi] = task_vector_bounds(RFm, J, Fend, alpha, muscle_i);
			%Tag on the next muscle's bound value
			lower_activation_vec = [lower_activation_vec , lo];
			upper_activation_vec = [upper_activation_vec , hi];
		else
			% We don't want to calculate these muscles. we set them as -1
			% just so the columns line up for selecting muscles by column later.
			lower_activation_vec = [lower_activation_vec , -1];
			upper_activation_vec = [upper_activation_vec , -1];
	end
end