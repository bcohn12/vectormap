%% task_vector_bounds: takes in a model, task direction and alpha.
% @output Activationbounds A 2xn_muscles database showing the 
% activation upper and lower bounds in order to meet alpha*fmax 
% for the task vector
% @param RFm matrix representing the output space
% @param J matrix representing the linear approximation of end effector motion
% @param Fend 6 element vector containing [x,y,z,t_x,t_y,t_z] direction.
% @param bounds_of_interest string 'upper_only', 'lower_only', 'upper_and_lower'
function [lower,upper] = task_vector_bounds(RFm, J, Fend, alpha,...
									 muscle_to_optimize, bounds_of_interest)
	%Normalize Fend input
	Fend = Fend/norm(Fend, 2);
	%Get the maximum feasible force in that direction
	max_f_output = get_magnitude_model_input(Fend, RFm, J);
	tau = J' * Fend;
	tau_max = tau * max_f_output;
	
%Solve for the activation, but only for the bounds of interest.
	switch bounds_of_interest
		case 'lower_only'
	    	lower = lower_activation(RFm, tau_max, alpha, muscle_to_optimize);
	       	upper = -1;
		case 'upper_only'
	    	lower = -1;
	       	upper = upper_activation(RFm, tau_max, alpha, muscle_to_optimize);
		case 'both'
	    	lower = lower_activation(RFm, tau_max, alpha, muscle_to_optimize);
	        upper = upper_activation(RFm, tau_max, alpha, muscle_to_optimize);
	end
end
