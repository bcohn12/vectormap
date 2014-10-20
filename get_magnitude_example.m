%% Set Working Directory
%cd('/Users/Olive/Documents/dev/bbdl/cat_model/sohn_data') %temporary
%cd('C:\Users\b\Documents\dev\sohn_data')

%% Load databases:
load('Sohn2013_hinlimb_models.mat')

%% Set up variables
num_points_to_evaluate = 80;

%% Generate the points to evaluate
MAT = random_surface_points(num_points_to_evaluate);
figure
% scatter3(MAT(:,1), MAT(:,2), MAT(:,3), 'fill'); %visualize vectors to optimize
scatter_figure(MAT(:,1), MAT(:,2), MAT(:,3)); %visualize vectors to optimize


%% Evaluate the fval and the activations of all muscles for every row of MAT. May take up to one hour per specimen.

cat1_normal = fval_matrix(1,MAT, 1);
cat2_normal = fval_matrix(2,MAT, 1);
cat3_normal = fval_matrix(3,MAT, 1);

%example of how to reduce strength of animal's muscle strength vector
%cat3_comp   = fval_matrix(3,MAT, .9);

% 
% %%Reload the values from disk to memory
% cat1_normal = csvread('output/jul11/sampled_fval_mat_cat1_pointnum_100000scaling1.csv');
% cat2_normal = csvread('output/jul11/sampled_fval_mat_cat2_pointnum_100000scaling1.csv');
% cat3_normal = csvread('output/jul11/sampled_fval_mat_cat3_pointnum_100000scaling1.csv');

% 

%% Plot the output-force scatter visualizations (setting log_transform to true) (base10 log)
% figure('Name','cat1 normal')
% fval_scatter(cat1_normal, true)
% figure('Name','cat2 normal')
% fval_scatter(cat2_normal,true)
% figure('Name','cat3 normal')
% fval_scatter(cat3_normal, true)
cat_vec = catdrawing_xy()*10
%% Plot the muscle activation 3d distributions
figure('Name','cat1 normalmuscle')
plot3(cat_vec(:,1),cat_vec(:,2), cat_vec(:,3))


cat_av = vectormap_mean(cat1_normal,cat2_normal,cat3_normal);
fval_scatter(cat_av,true)
axis square
cat_std = vectormap_std(cat1_normal,cat2_normal,cat3_normal);
fval_scatter(cat_std,true)
axis square

heatmap_pdfs_for_all_muscles(cat_av, 'av_activation')
heatmap_pdfs_for_all_muscles(cat_std, 'std_activation')
heatmap_pdfs_for_fval(cat_av, 'FmaxAverage_Newtons')
heatmap_pdfs_for_fval(cat_std, 'Fmax_std')
close all



