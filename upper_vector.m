function [ UPPER_VEC ] = upper_vector( RFm, tau_max, alpha_intervals, muscle_num, muscle_to_optimize)
%@param RFm
%@param tau_max
%@param alpha_intervals
%@param muscle_num
%@param muscle_to_optimize
%@return LOWER_VEC
    UPPER_MAT = zeros(alpha_intervals, muscle_num+1);
    upperbound = ones(muscle_num,1) ;
    lowerbound = zeros(muscle_num,1) ;
    f = number_among_zeros(1,muscle_to_optimize,muscle_num)
    counter=1
    for alpha=linspace(0,1,alpha_intervals)
        b = alpha * tau_max;
        A = RFm; %you don't inlcude tau here
        options=optimset('Display', 'none'); %Suppressing Optimization Terminated message
        [x,fval,exitflag,output,lambda] = linprog(f,[],[],A,b,lowerbound, upperbound,[], options);
        UPPER_MAT(counter, 1) = alpha; %first column lists the alpha
        for i=1:length(x)
            UPPER_MAT(counter,i+1) = x(i); %next columns show activation at given alpha
        end
        counter = counter + 1;
    end
    UPPER_VEC = UPPER_MAT(:,muscle_to_optimize+1)

end

