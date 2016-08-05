%@title Finding the upper and lower (task-specific) bounds of a muscle's activation.
%@description Cat models in Sohn et al 2013 are used to model the bounds of
%feasible muscle activations.
%@author Brian Cohn <brian_cohn14@pitzer.edu>
%@version 1.0
load('Sohn2013_hinlimb_models.mat')
Fend = [1.1,1.9,0,0,0,0]'; %defining an output direction (vector)
Fend = Fend/norm(Fend,2);
muscle_num = 31;
alpha_var = 1;
alpha_intervals = 10;
specimens=3;

%
% Pre-allocate memory for the database
%
colnames = ['specimen', 'muscle', 'alpha', 'lower', 'upper'];
muscle_db = zeros(1, 5);

for specimen_number = 1:length(Cats)
    
    cat = specimen_number;
    display('computing cat #'); display(cat);
    %
    % Identify the magnitude of the task vector.
    %

    % Pull data for a specimen
    tau = (Cats{1,cat}.J)' * Fend;
    RFm = Cats{1,cat}.R * diag(afl95 * (fmax .* cosa95));

    % Move data into linear program format.
    f = [zeros(muscle_num,1);-1];
    A = [RFm, -tau];
    upperbound = [ones(muscle_num,1); Inf];
    lowerbound = [zeros(muscle_num,1); 0];
    b = zeros(7,1);
    % Use the linear program solver to find the maximal feasible possible ouptut magnitude for the task
    options=optimset('Display', 'none');
    [x,fval,exitflag,output,lambda] = linprog(f,[],[],A,b,lowerbound, upperbound, [], options);
    max_f_output = -1*fval; % max force in the desired vector
    max_f_vector = max_f_output*Fend; % the max vector
    tau_max = tau*max_f_output;
    %
    % Optimize for each muscle
    %

    %create an n by n plotting grid
    n = ceil(sqrt(length(RFm(1,:))));
    % iterate over each muscle to report the lower and upper bounds of the
    % activation across varying alpha (target force output magnitude)
    figure(specimen_number)
    pbaspect([1,1,1])
    current_index = 1;
    for muscle_i = 1:length(RFm(1,:))
        muscle_alpha_mat = activation_bounds(RFm, tau_max, alpha_intervals, muscle_i); %muscle num is the muscle we are optimizing
        specimen_rep = ones(alpha_intervals,1)*specimen_number;
        muscle_rep = ones(alpha_intervals,1)*muscle_i;
        this_muscle_mat = [specimen_rep, muscle_rep, muscle_alpha_mat]; %append it to the db
        muscle_db = [muscle_db ; this_muscle_mat];
        subplot(n,n,muscle_i);
        bounds_plot(muscle_alpha_mat(:,1),muscle_alpha_mat(:,2), muscle_alpha_mat(:,3), muscles(muscle_i));
    end %muscle loop
    
end %specimen loop


csvwrite('output/muscle_database.csv',muscle_db)
