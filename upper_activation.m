
function [ upper_activation ] = upper_activation( RFm, tau_max, alpha,...
												 muscle_to_optimize)
% takes in model parameters, outputs the upperbound activation (between 0 and 1, double)
    muscle_num = length(RFm(1,:));
    upperbound = ones(muscle_num,1) ; 
    lowerbound = zeros(muscle_num,1) ;
    f = number_among_zeros(-1,muscle_to_optimize,muscle_num);
    b = alpha * tau_max;
    A = RFm; %you don't inlcude tau here
    options=optimset('Display', 'none'); %suppressing "Optimization terminated." message
    [x,fval,exitflag,output,lambda] = linprog(f,[],[],A,b,lowerbound, upperbound, [], options);
    upper_activation = x(muscle_to_optimize);

end
