function [ LOWER_VEC ] = lower_vector( RFm, tau_max, alpha_intervals, muscle_num, muscle_to_optimize)
    LOWER_MAT = zeros(alpha_intervals, muscle_num+1);
    upperbound = ones(muscle_num,1) ;
    lowerbound = zeros(muscle_num,1) ;
    counter=1;
    f = number_among_zeros(-1,muscle_to_optimize,muscle_num)
    for alpha=linspace(0,1,alpha_intervals)
        b = alpha * tau_max;
        A = RFm; %you don't inlcude tau here
        options=optimset('Display', 'none'); %suppressing "Optimization terminated." message
        [x,fval,exitflag,output,lambda] = linprog(f,[],[],A,b,lowerbound, upperbound, [], options);
        LOWER_MAT(counter, 1) = alpha; %first column lists the alpha
        for i=1:length(x)
            LOWER_MAT(counter,i+1) = x(i); %next columns show activation at given alpha
        end
        counter = counter + 1;
    end
    LOWER_VEC = LOWER_MAT(:,muscle_to_optimize+1)

end


