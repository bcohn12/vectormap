	load('Sohn2013_hinlimb_models.mat')
    cat = 1;
    fval_scaling = 1; %to cut force strength in half, set to 0.5
    muscle_vector_scaling = 1;
	cat_Fm = diag(afl95 * (fmax .* cosa95));
	cat_R = Cats{1,cat}.R;
	cat_J = Cats{1,cat}.J;
	diag_muscle_parameters = diag(afl95 * (muscle_vector_scaling*fmax .* cosa95));
	RFm = cat_R*diag_muscle_parameters;