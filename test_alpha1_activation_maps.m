load('Sohn2013_hinlimb_models.mat')
addpath('sphere_pointpicking/uniform_s2_sampling/');
cat=1;
n_alpha=1;
n_unitvectors=5000;
pointpicking_method= 'triangulation';
fmax_scale = 1;
fval_scaling = fmax_scale;
cat_Fm = diag(afl95 * (fmax_scale*fmax .* cosa95));
cat_R = Cats{1,cat}.R;
cat_J = Cats{1,cat}.J;
diag_muscle_parameters = diag(afl95 * (fmax_scale*fmax .* cosa95));
RFm = cat_R*diag_muscle_parameters;
muscles_of_interest = [30 13 25]; % All other muscle columns wil be set to -1 to indicate
bounds_of_interest = 'both';
alphamin = 1;
alphamax = 1;
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
    case 'robinsonprep'
        unit_vectors = mat_from_1d_csv();
end
% --------------------------------------------------

title_str=' ';
[magnitudes, activations] = fval_maximize(RFm, cat_J, unit_vectors, 1);
zerotorques = zeros(n_unitvectors,3);

force_task_mat = [unit_vectors , zerotorques, magnitudes];
force_task_scatter(force_task_mat,1,false, false);
pdf_task_scatter(title_str, 'figs/fval_max_cat1');
activation_task_mat = [unit_vectors , zerotorques, activations];

for m = muscles_of_interest
	task_scatter(activation_task_mat, m, false);
	file_string = strcat('figs/m', num2str(m), 'activation_at_mvic');
	pdf_task_scatter(title_str, file_string);
end