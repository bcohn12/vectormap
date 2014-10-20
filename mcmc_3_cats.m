% MONTE CARLO PERMUTATIONS TO THE R matrix of cat1
load('Sohn2013_hinlimb_models.mat')
cat=1;
fmax_scale=1;
n_unit_vectors = 1000; %how many points are sampled to identify the max and min direction
mc_iterations = 20; %number of time the monte carlo is set by default
fmax_direction_mc_iterations = 10000; %overestimate of the number of expected iterations.
lowerbound=0.75;% will change a given cell from the R matrix between -25 and +25%.
upperbound=1.25;

cat_Fm = diag(afl95 * (fmax_scale*fmax .* cosa95));
cat_R = Cats{1,cat}.R;
cat_J = Cats{1,cat}.J;
diag_muscle_parameters = diag(afl95 * (fmax_scale*fmax .* cosa95));

%end parameters
% Ask which direction yields the maximum fval for each cat. 
% Get the average unit vector that's the average of all 3 cat's directions.
[task_min, task_max] = cats_task_bounds(1000);
unit_vectors = [task_min; task_max]
%run monte carlo analysis on max direction vectors, when changing the R matrix:

%see how the max direction changes with further MC manipulation

max_fval_iteration_vec = mcmc_cumulative_fval_point(cat_R, cat_Fm, cat_J, ...
	diag_muscle_parameters, task_max,  ...
 	lowerbound, upperbound, fmax_direction_mc_iterations);
fval_variance = running_variance(max_fval_iteration_vec', 50)
plot(fval_variance)

min_fval_iteration_vec = mcmc_cumulative_fval_point(cat_R, cat_Fm, cat_J, ...
	diag_muscle_parameters, task_min,  ...
 	lowerbound, upperbound, fmax_direction_mc_iterations);
fval_variance = running_variance(min_fval_iteration_vec', 50)
plot(fval_variance)

break

%select an iteration number

% run MCMC with computed iteration number

%find the max direction
unit_vectors = random_surface_points(n_unit_vectors);
fval_mc = mcmc_cumulative_fval_matrix(cat_R, cat_Fm, cat_J, ...
	diag_muscle_parameters, unit_vectors,  ...
 	lowerbound, upperbound, mc_iterations); % fval_mc is the average fval matrix for cat1's derivatives








%run monte carlo with calculated number of iterations:
% TODO replace n_unit_vectors with calculated iterations
unit_vectors = random_surface_points(n_unit_vectors);
fval_mc = mcmc_cumulative_fval_matrix(cat_R, cat_Fm, cat_J, ...
	diag_muscle_parameters, unit_vectors,  ...
 	lowerbound, upperbound, mc_iterations);
% fval_mc is the average fval matrix for cat1's derivatives
fval_scatter(fval_mc, false)
