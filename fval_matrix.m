function [ fval_matrix ] = fval_matrix( cat, MAT, fval_scaling )
%MAT is the matrix of XYZ vectors to check.
% cat is 1 2 or 3  (int)
%saves the matrix to the output folder with the number of the cat.
randpoint_num = length(MAT(:,1));
%Initialize database to hold evaluation data
fval_matrix = [];
lenmat = length(MAT(:,1));
% iterate over every vector in MAT
for row= 1:lenmat
    forcevec = [MAT(row,1), MAT(row,2), MAT(row,3), 0, 0, 0]; % current
    Fend = forcevec'; %defining an output direction (vector)
    Fend = Fend/norm(Fend,2);
    forcevec = Fend';
    [magnitude, activation_vec] = get_magnitude(forcevec', cat, fval_scaling);
    entry = [forcevec, magnitude];
    [theta,phi] = vector_2_spherical(entry);
    [lat,lon] = to_degrees(theta,phi);
    [TH,PHI,R] = cart2sph(forcevec(1),forcevec(2),forcevec(3));
    entry = [entry, lon, lat, TH, PHI, activation_vec'];
    fval_matrix = [fval_matrix ; entry];
    if mod(row, 100) == 0
        fprintf('Iteration : %u/ %u  \n',row, lenmat);
    end
end
% KEY: fval matrix has [xyz torquex torquey torquez, magnitude, lon, 
% lat,theta, elevation, m1, m2, ... , m31]
filename = strcat('output/sampled_fval_mat_cat', num2str(cat),...
 '_pointnum_',num2str(randpoint_num),'scaling', num2str(fval_scaling), '.csv');
csvwrite(filename,fval_matrix)

end

