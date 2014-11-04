load('Sohn2013_hinlimb_models.mat')
cat=1;
n_alpha=5;
% n_unitvectors=50000;
% unit_vectors = random_surface_points(n_unitvectors);
unit_vectors = dlmread('vectors1.txt', ' ');
fmax_scale = 1;
fval_scaling = fmax_scale;
cat_Fm = diag(afl95 * (fmax_scale*fmax .* cosa95));
cat_R = Cats{1,cat}.R;
cat_J = Cats{1,cat}.J;
diag_muscle_parameters = diag(afl95 * (fmax_scale*fmax .* cosa95));
RFm = cat_R*diag_muscle_parameters;
muscles_of_interest = [29, 30]; % All other muscle columns wil be set to -1 to indicate
% they were not computed
i = 1; %

C = cell(3,n_alpha);
h = waitbar(0, 'wait');
for alpha = linspace(0.5,.9,n_alpha),
	[ lowerbound_mat, upperbound_mat ] = activation_bound_matrices( ...
			RFm, cat_J, unit_vectors, fval_scaling, alpha, muscles_of_interest );
	C{1,i} = strcat('Alpha=', num2str(alpha));
	C{2,i} = lowerbound_mat;
	C{3,i} = upperbound_mat;
	i = i+1; %Increment Counter
	percentdone = i/n_alpha; %calculate the progress of the loop
	waitbar(percentdone); %display progress on waitbar
end
close(h)