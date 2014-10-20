function [ magnitude, activation_vec ] = get_magnitude_model_input( ...
	Fend, RFm, J)
	%
	% Identify the magnitude of the task vector.
	%
	% takes in a muscle/geometric model
	% @Fend has to be like this:  [1.1,1.9,0,0,0,0]' 
	% @param RFm matrix which could look like this: 
	% RFm = Cats{1,cat}.R * diag(afl95 * (fmax_scale*fmax .* cosa95));
	% output: a magnitude for the given vector.

	Fend = Fend/norm(Fend,2);
	muscle_num = 31;
	alpha_var = 1;
	alpha_intervals = 16;
	specimens=3;



	% Pull data for a specimen
	tau = (J)' * Fend;

	% Move data into linear program format.
	f = [zeros(muscle_num,1);-1];
	A = [RFm, -tau];
	upperbound = [ones(muscle_num,1); Inf];
	lowerbound = [zeros(muscle_num,1); 0];
	b = zeros(7,1);
	% Use the linear program solver to find the maximal feasible possible ouptut magnitude for the task
	options=optimset('Display', 'none');

	[x,fval,exitflag,output,lambda] = linprog(f,[],[],A,b,lowerbound, upperbound, [], options);
	max_f_output = -1*fval; % max force in the desired vector
	max_f_vector = max_f_output*Fend; % the max vector
	magnitude = max_f_output;
	activation_vec = x(1:end-1); %remove the extra cell

end

