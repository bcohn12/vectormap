function [ magnitudes, activations ] = fval_maximize( RFm, J, MAT, fval_scaling )
%MAT is the matrix of XYZ vectors to check.
% @output fval_matrix matrix with columns: x, y, z, tx, ty, tz, magnitude, lon, lat, TH, PHI, activation_vec
% example:
% load('Sohn2013_hinlimb_models.mat')
% a = fval_matrix_model_input(Cats{1,1}.R * diag(afl95 * (fmax_scale*1 .* cosa95)),...
 % Cats{1,1}.J, random_surface_points(8),1)
% KEY: fval matrix has [xyz torquex torquey torquez, magnitude, lon, 
% lat,theta, elevation, m1, m2, ... , m31]
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
    [magnitude, activation_vec] = get_magnitude_model_input(forcevec', RFm, J);
    entry = [forcevec, magnitude];
    [theta,phi] = vector_2_spherical(entry);
    [lat,lon] = to_degrees(theta,phi);
    [TH,PHI,R] = cart2sph(forcevec(1),forcevec(2),forcevec(3));
    entry = [entry, lon, lat, TH, PHI, activation_vec'];
    fval_matrix = [fval_matrix ; entry];
    if mod(row, 1000) == 0
        fprintf('Vectorpoint: : %u/ %u  \n',row, lenmat);
    end
end
magnitudes = fval_matrix(:,7);
activations = fval_matrix(:, 12:end);

end
