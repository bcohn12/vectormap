load('Sohn2013_hinlimb_models.mat')
addpath('sphere_pointpicking/uniform_s2_sampling/');

n_alpha=1;
n_unitvectors=5000;
pointpicking_method= 'triangulation';% --------------------------------------------------
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
cat=1;
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


title_str=' ';
[magnitudes1, activations1] = fval_maximize(RFm, cat_J, unit_vectors, 1);
zerotorques = zeros(n_unitvectors,3);

force_task_mat1 = [unit_vectors , zerotorques, magnitudes1];







% --------------------------------------------------
cat=2;
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


title_str=' ';
[magnitudes2, activations2] = fval_maximize(RFm, cat_J, unit_vectors, 1);
zerotorques = zeros(n_unitvectors,3);

force_task_mat1 = [unit_vectors , zerotorques, magnitudes2];


% --------------------------------------------------
cat=3;
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


title_str=' ';
[magnitudes3, activations3] = fval_maximize(RFm, cat_J, unit_vectors, 1);
zerotorques = zeros(n_unitvectors,3);

force_task_mat1 = [unit_vectors , zerotorques, magnitudes3];



%-----------------




meanmagnitudes = sum([magnitudes1'; magnitudes2'; magnitudes3'])/3.0;
meanmagnitudes = meanmagnitudes';

var_mag = var([magnitudes1'; magnitudes2'; magnitudes3'])
sd_mag = sqrt(var_mag)';

force_task_scatter_mean = [unit_vectors, zerotorques, meanmagnitudes];
force_task_scatter(force_task_scatter_mean, 1, false, false)
pdf_task_scatter(title_str, 'figs/fmax_species_av');


sd_mat = [unit_vectors,zerotorques,sd_mag];
force_task_scatter(sd_mat, 1 , false, false)
pdf_task_scatter(title_str, 'figs/fmax_species_sd');










force_task_scatter(force_task_mat,1,false, false);
pdf_task_scatter(title_str, 'figs/fval_max_cat1');