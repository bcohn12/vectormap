load('Sohn2013_hinlimb_models.mat')
% cd('/Users/Olive/Documents/dev/bbdl/cat_model/sohn_data') %temporary

Rav = (Cats{1,1}.R + Cats{1,2}.R + Cats{1,3}.R)/3.0;

n = 3

s = (Cats{1,1}.R - Rav).^2 + (Cats{1,2}.R - Rav).^2 + (Cats{1,3}.R - Rav).^2
s = s./2
s = s.^0.5


csvwrite('output/R_av.csv',Rav)
csvwrite('output/R_sd.csv',s)