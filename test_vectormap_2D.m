%buildup
load('Sohn2013_hinlimb_models.mat')
alpha=0.5
cat=1;
Fend= [1,1,1,0,0,0]'
muscle_to_optimize=1;
fmax_scale = 1;
cat_Fm = diag(afl95 * (fmax_scale*fmax .* cosa95));
cat_R = Cats{1,cat}.R;
cat_J = Cats{1,cat}.J;
diag_muscle_parameters = diag(afl95 * (fmax_scale*fmax .* cosa95));
RFm = cat_R*diag_muscle_parameters;

planes = ['xy','yz','xz']
n=17
[ fval_mat ] = vectormap_2D(RFm, cat_J, 'xy', n)
%tests
% for plane = planes
% 	[ fval_mat ] = vectormap_2D(RFm, cat_J, plane, n)
% end