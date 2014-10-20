% takes in only one unitvector, and outputs a list containing the fvals for each iteration.
function [ fv_vector ] = mcmc_cumulative_fval_matrix( ...
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
	fv_vector = [];
	for i = 1:iterations,
		R_temp = uniform_mcmc_mat(R_lower, R_upper);
		RFm = R_temp * diag_muscle_parameters;
		fval_iter = fval_matrix_model_input(RFm, J, unitvectors, 1);
		fv_cumulative = fv_cumulative + fval_iter;
        waitbar(i/iterations)
        fv_vector = [fv_vector, fval_iter(1,7)];


	end
	close(h)

end

