load('Sohn2013_hinlimb_models.mat')
addpath('sphere_pointpicking/uniform_s2_sampling/');
cat=1;
n_alpha=5;
n_unitvectors=5000;
pointpicking_method= 'triangulation';
fmax_scale = 1;
fval_scaling = fmax_scale;
cat_Fm = diag(afl95 * (fmax_scale*fmax .* cosa95));
cat_R = Cats{1,cat}.R;
cat_J = Cats{1,cat}.J;
diag_muscle_parameters = diag(afl95 * (fmax_scale*fmax .* cosa95));
RFm = cat_R*diag_muscle_parameters;
muscles_of_interest = [5,9,13,14,16,18,19,20,21,23,25,27,30]; % All other muscle columns wil be set to -1 to indicate
bounds_of_interest = 'both';
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
%normal, preserved fmax version
C = alpha_activation_progression(RFm, cat_J, unit_vectors, fval_scaling, n_alpha, alphamin, ...
	alphamax, muscles_of_interest, bounds_of_interest, show_alpha_waitbar)

%make a compensated (scaled) version for a few muscles on one nerve
compensated_muscles = [5, 19, 27];
fmax_scaled = scale_muscle_fmax(fmax, compensated_muscles, 0.5); 

diag_muscle_parameters = diag(afl95 * (fmax_scale*fmax_scaled .* cosa95));
RFm = cat_R*diag_muscle_parameters;

C_scaled = alpha_activation_progression(RFm, cat_J, unit_vectors, fval_scaling, n_alpha, alphamin, ...
	alphamax, muscles_of_interest, bounds_of_interest, show_alpha_waitbar);
% save for later
save('output/C_scaled_13_14_16_18_19_20_21_23_25_30_27_5_both.mat', 'C_scaled')
save('output/C_13_14_16_18_19_20_21_23_25_30_27_5_both.mat', 'C')


% Plot the progression for each muscle:
pdfs_alpha_progression(C,31, 'normal_fmax')
pdfs_alpha_progression(C_scaled,31, 'fmax_scaled_pero_50')    