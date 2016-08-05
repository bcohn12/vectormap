load('Sohn2013_hinlimb_models.mat') 
% Thank you Hongchul for the data! http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4021711/
cat=1; %there are three feline specimens to choose from.

Fend= [1,1,1,0,0,0]'; 
%this is the output task (static endpoint force)

alpha=0.5;
% To find the max and min activation for a given muscle for a given task,
% choose how intense the task endpoint force is.

fmax_scale = 1; 
% You can scale down the strength of all muscles to 50% of maximal feasible tendon force acoss all muscles, by setting this to 0.5

cat_R = Cats{1,cat}.R;
% the moment arm matrix R records (in centimeters) the leverage that each muscle has on each rotational DOF (degree of freedom).

cat_J = Cats{1,cat}.J; 
% the jacobian is responsible for defining, for each DOF, the instantaneous linear direction that the endpoint moves when that DOF rotates.

diag_muscle_parameters = diag(afl95 * (fmax_scale*fmax .* cosa95));
% here let's compose the muscle parameters in a diagonal matrix, so we can
% multiply it by the moment arm matrix & jacobian.
% where afl95 is a vector of scaling factors based on the active force-length property of muscle (Zajac, 1989)
% where cosa95 sets all muscles to 95% optimal fiber length (Burkholder and Lieber, 2001; Roy et al., 1997; Sacks and Roy, 1982)
RFm = cat_R*diag_muscle_parameters;

bounds_of_interest = 'both';
% for one muscle, let's check out what its min and max values are!
muscles % here are all of the feline hindlimb muscles you can choose from

muscle_to_optimize=1;% muscle number 1 is adf = Adductor Femoris
muscles; % muscle names stored here
% All muscles you can choose from are detailed here: http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4021711/table/T1/

[lo, hi] = task_vector_bounds(RFm, cat_J, Fend, alpha,...
									 muscle_to_optimize, bounds_of_interest);
% For a given task, there's an infinite solution space for the muscles to
% achieve that task. Use the task_vector_bounds function to understand the
% max and min that a given muscle is used across all solutions.

% for every available muscle, for a given force task, let's get the lower
% bound of activation and upper bound of activation
lower_activation_vec = [];
upper_activation_vec = [];
for muscle_i = 1:length(RFm) %maximize and minimize each muscle
	% record the activation bounds for each muscle for the given Fend.
	[lo, hi] = task_vector_bounds(RFm, cat_J, Fend, alpha, muscle_i, bounds_of_interest);
	lower_activation_vec = [lower_activation_vec , lo];
	upper_activation_vec = [upper_activation_vec , hi];
end

%your goal:
% 1. Pick your favorite leg muscle
% 2. Design a question 
