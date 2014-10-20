%% task_vector_bounds: takes in a model, task direction and alpha.
% @output Activationbounds A 2xn_muscles database showing the 
% activation upper and lower bounds in order to meet alpha*fmax 
% for the task vector
% @param RFm matrix representing the output space
% @param J matrix representing the linear approximation of end effector motion
% @param Fend 6 element vector containing [x,y,z,t_x,t_y,t_z] direction.
function [lower,upper] = task_vector_bounds(RFm, J, Fend, alpha,...
									 muscle_to_optimize)
	%Normalize Fend input
	Fend = Fend/norm(Fend, 2);
	%Get the maximum feasible force in that direction
	max_f_output = get_magnitude_model_input(Fend, RFm, J);
	tau = J' * Fend;
	tau_max = tau * max_f_output;
	
%Solve for the minimal 
	upper = upper_activation(RFm, tau_max, alpha, muscle_to_optimize);
    lower = lower_activation(RFm, tau_max, alpha, muscle_to_optimize);
