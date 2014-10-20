function [ magnitude, activation_vec ] = get_magnitude( ...
	Fend, cat_number, fmax_scale)
%
% Identify the magnitude of the task vector.
%
% takes in a muscle/geometric model
% @Fend has to be like this:  [1.1,1.9,0,0,0,0]' 
% (transposed so it's vertical)
% output: a magnitude for the given vector.

load('Sohn2013_hinlimb_models.mat')
% cd('/Users/Olive/Documents/dev/bbdl/cat_model/sohn_data') %temporary

Fend = Fend/norm(Fend,2);
muscle_num = 31;
alpha_var = 1;
alpha_intervals = 16;
specimens=3;
specimen_number = cat_number;

cat = specimen_number;


% Pull data for a specimen
tau = (Cats{1,cat}.J)' * Fend;
RFm = Cats{1,cat}.R * diag(afl95 * (fmax_scale*fmax .* cosa95));

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

