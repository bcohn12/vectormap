load('Sohn2013_hinlimb_models.mat')
alpha=0.5
cat=1;
Fend= [1,1,1,0,0,0]'
muscle_to_optimize=1;
fmax_scale = 1;
cat_Fm = diag(afl95 * (fmax_scale*fmax .* cosa95));
cat_R = Cats{1,cat}.R;
cat_J = Cats{1,cat}.J;
diag_muscle_parameters = diag(afl95 * (fmax_scale*fmax .* cosa95));
RFm = cat_R*diag_muscle_parameters;
bounds_of_interest = 'upper_only';
%for one muscle
[lo, hi] = task_vector_bounds(RFm, cat_J, Fend, alpha,...
									 muscle_to_optimize, bounds_of_interest)

%for multiple muscles
lower_activation_vec = [];
upper_activation_vec = [];
for muscle_i = 1:length(RFm) %maximize and minimize each muscle
	% record the activation bounds for each muscle for the given Fend.
	[lo, hi] = task_vector_bounds(RFm, cat_J, Fend, alpha, muscle_i, bounds_of_interest);
	lower_activation_vec = [lower_activation_vec , lo];
	upper_activation_vec = [upper_activation_vec , hi];
end