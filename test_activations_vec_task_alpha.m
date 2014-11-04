load('Sohn2013_hinlimb_models.mat')
alpha=0.5
cat=1;
Fend= [1,1,1,0,0,0]'
fmax_scale = 1;
cat_Fm = diag(afl95 * (fmax_scale*fmax .* cosa95));
cat_R = Cats{1,cat}.R;
cat_J = Cats{1,cat}.J;
diag_muscle_parameters = diag(afl95 * (fmax_scale*fmax .* cosa95));
RFm = cat_R*diag_muscle_parameters;

%muscles that will be collected into the matrix. all else will be set as negative 1 (an impossible activation)
muscles_of_interest = [1, 5, 25, 30, 31];


[lovec, hivec]= activations_vec_task_alpha(RFm, cat_J, Fend, alpha, muscles_of_interest)
