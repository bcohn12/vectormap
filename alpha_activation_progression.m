% Generates a cell array which represents a collection of activation bound matrices. 
% Each cell contains the model at a value of alpha (the amount of force pushed in the task direction)
function [C] = alpha_activation_progression(RFm, J, unit_vectors,...
	 fval_scaling, n_alpha,alphamin, alphamax, muscles_of_interest,...
	  bounds_of_interest, show_alpha_waitbar)
	i = 1; %
	C = cell(3,n_alpha);
	if show_alpha_waitbar
		h = waitbar(0, 'wait');
	end
	for alpha = linspace(alphamin, alphamax, n_alpha),
		[ lowerbound_mat, upperbound_mat ] = activation_bound_matrices( ...
				RFm, J, unit_vectors, fval_scaling, alpha, ...
				muscles_of_interest, bounds_of_interest );
		C{1,i} = strcat('Alpha=', num2str(alpha));
		C{2,i} = lowerbound_mat;
		C{3,i} = upperbound_mat;
		i = i+1; %Increment Counter
		percentdone = i/n_alpha; %calculate the progress of the loop
		if show_alpha_waitbar
			waitbar(percentdone); %display progress on waitbar
		end
	end
	if show_alpha_waitbar
		close(h)
	end
end