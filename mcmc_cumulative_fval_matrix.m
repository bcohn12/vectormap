% @param R input numeric matrix with no NA values.
% @param lowerbound and upper bound at 0.5 to 1.5 would ...
% mean +/- 50% the R value per cella
% careful with the sizes here! the algorithm is big o(iterations*n_unitvectors)
% example code: 
% mcmc_cumulative_fval_matrix(ones(7,31), 0.5,1.5, 100)
function [ fv_cumulative ] = mcmc_cumulative_fval_matrix( ...
	R, Fm, J, diag_muscle_parameters, unitvectors, ...
	lowerbound, upperbound, iterations)

	R_upper = R*upperbound; %this is the R matrix scaled by upperbound
	R_lower = R*lowerbound; %this is the R matrix scaled by lowerbound
	
	R_temp = zeros(size(R)); %initiate a matrix at zero

	R_temp = uniform_mcmc_mat(R_lower, R_upper);
	RFm = R_temp * diag_muscle_parameters;
	% RFm = R_temp * diag(afl95 * (fmax_scale*fmax .* cosa95));
	fval_blank = fval_matrix_model_input(RFm, J, unitvectors, 1);
	fv_cumulative = zeros(size(fval_blank));

	h = waitbar(0, 'wait.');
	for i = 1:iterations,
		counter=0;
		R_temp = uniform_mcmc_mat(R_lower, R_upper);
		RFm = R_temp * diag_muscle_parameters;
		% RFm = R_temp * diag(afl95 * (fmax_scale*fmax .* cosa95));
		fval_iter = fval_matrix_model_input(RFm, J, unitvectors, 1);
		fv_cumulative = fv_cumulative + fval_iter;
		counter=counter+1;
		% if mod(counter, 2) == 0
        waitbar(i/iterations)
    	% end

	end
	close(h)
	fv_cumulative./iterations
	fv_cumulative(:,1) = unitvectors(:,1)
	fv_cumulative(:,2) = unitvectors(:,2)
	fv_cumulative(:,3) = unitvectors(:,3)
	disp(iterations)
end

