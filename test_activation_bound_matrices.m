load('Sohn2013_hinlimb_models.mat')
%Set up test parameters
alpha=0.5
cat=1;
n_unitvectors=100;
unit_vectors = random_surface_points(n_unitvectors);
fmax_scale = 1;
fval_scaling = fmax_scale;
cat_Fm = diag(afl95 * (fmax_scale*fmax .* cosa95));
cat_R = Cats{1,cat}.R;
cat_J = Cats{1,cat}.J;
diag_muscle_parameters = diag(afl95 * (fmax_scale*fmax .* cosa95));
RFm = cat_R*diag_muscle_parameters;
%End test parameters
muscles_of_interest = [1, 5, 25, 30, 31];
[ lowerbound_mat, upperbound_mat ] = activation_bound_matrices( ...
	RFm, cat_J, unit_vectors, fval_scaling, alpha, muscles_of_interest );
