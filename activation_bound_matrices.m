% RFm, J are the model parameters
% unitvectors is a matrix where each row is a task vector
% fval_scaling Double or Integer which defines how strong all of the muscles are. 1.1 would be a 10% increase in strength.
% alpha Percentage of fmax for a task vector. Between 0 and 1.
function [ lowerbound_mat, upperbound_mat ] = activation_bound_matrices( ...
    RFm, J, unitvectors, fval_scaling, alpha, muscles_of_interest , bounds_of_interest)
% KEY: fval matrix has [xyz torquex torquey torquez, magnitude, lon, 
% lat,theta, elevation, m1, m2, ... , m31]
randpoint_num = length(unitvectors(:,1));
%Initialize database to hold evaluation data
lowerbound_mat = [];
upperbound_mat = [];
lenmat = length(unitvectors(:,1));

% h = waitbar(0, 'Cycling through each muscle');
% for every unit vector in unitvectors, compute the activations upper and lower bound
for row= 1:lenmat
    forcevec = [unitvectors(row,1), unitvectors(row,2), unitvectors(row,3),...
                 0, 0, 0]; % current
    Fend = forcevec'; %defining an output direction (vector)
    Fend = Fend/norm(Fend,2);
    forcevec = Fend';
    [lovec, hivec]= activations_vec_task_alpha(RFm, J, forcevec', alpha, muscles_of_interest, bounds_of_interest);
    %Paste in the lower bound vector of activations
    lo_entry = [forcevec, lovec];
    lowerbound_mat = [lowerbound_mat ; lo_entry];
    %Paste in the upper bound vector of activations
    hi_entry = [forcevec, hivec];
    upperbound_mat = [upperbound_mat ; hi_entry];
    percentdone = row/lenmat;
    if mod(row,10)==0
        fprintf(strcat('alpha[', num2str(alpha), ']  Directions[', num2str(row), '/', num2str(lenmat), ']\n'))
    % waitbar(percentdone, strcat(num2str(alpha),' is alpha;',num2str(row),' points so far'));
end
% close(h)

end
