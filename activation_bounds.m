function [ mat ] = activation_bounds( RFm, tau_max, alpha_intervals,...
									 muscle_to_optimize )
    alpha_vec = linspace(0,1,alpha_intervals);
    mat = ones(length(alpha_vec),3);
    for i=1:length(alpha_vec);
        mat(i,1)= alpha_vec(i);
        mat(i,2)= lower_activation( RFm, tau_max, alpha_vec(i), muscle_to_optimize);
        mat(i,3)= upper_activation( RFm, tau_max, alpha_vec(i), muscle_to_optimize);
    end
    
end

