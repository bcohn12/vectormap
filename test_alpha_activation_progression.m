load('Sohn2013_hinlimb_models.mat')
addpath('sphere_pointpicking/uniform_s2_sampling/');
cat=1;
n_alpha=5;
n_unitvectors=2000;
pointpicking_method= 'triangulation';
fmax_scale = 1;
fval_scaling = fmax_scale;
cat_Fm = diag(afl95 * (fmax_scale*fmax .* cosa95));
cat_R = Cats{1,cat}.R;
cat_J = Cats{1,cat}.J;
diag_muscle_parameters = diag(afl95 * (fmax_scale*fmax .* cosa95));
RFm = cat_R*diag_muscle_parameters;
muscles_of_interest = [30]; % All other muscle columns wil be set to -1 to indicate
bounds_of_interest = 'lower_only';
alphamin = 0.5;
alphamax = 0.9;
show_alpha_waitbar=true;

% --------------------------------------------------
switch pointpicking_method
	case 'random'
		unit_vectors = random_surface_points(n_unitvectors);
	case 'triangulation'
		% Nitr is the number of triangle mnodification iterations to minimize energy.
		[V,Tri,~,Ue]=ParticleSampleSphere('N',n_unitvectors, 'Nitr', 100);
		unit_vectors = V;
	case 'vectors1_from_python'
		unit_vectors = dlmread('vectors1.txt', ' ');
end
% --------------------------------------------------

C = alpha_activation_progression(RFm, cat_J, unit_vectors, fval_scaling, n_alpha, alphamin, ...
	alphamax, muscles_of_interest, bounds_of_interest, show_alpha_waitbar)

