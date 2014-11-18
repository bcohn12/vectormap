load('Sohn2013_hinlimb_models.mat')
%Set up test parameters
alpha=0.9
cat=1;
unit_vectors = mat_from_1d_csv();
fmax_scale = 1;
fval_scaling = fmax_scale;
cat_Fm = diag(afl95 * (fmax_scale*fmax .* cosa95));
cat_R = Cats{1,cat}.R;
cat_J = Cats{1,cat}.J;
diag_muscle_parameters = diag(afl95 * (fmax_scale*fmax .* cosa95));
RFm = cat_R*diag_muscle_parameters;
%End test parameters
muscles_of_interest = [30]; %these are the muscles we will compute. other muscles won't be computed
bounds_of_interest = 'lower_only' % compute for lower and upper
[ lowerbound_mat, upperbound_mat ] = activation_bound_matrices( ...
	RFm, cat_J, unit_vectors, fval_scaling, alpha, muscles_of_interest, bounds_of_interest );
