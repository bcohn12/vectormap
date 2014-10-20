function [] = fval_scatter( fval_matrix , log_transform)
%Generates a scatter plot of the fval_matrix, where the log of the 7th
%column is displayed in heat color.
if log_transform
    colorvec = log10(fval_matrix(:,7));
else
    colorvec = fval_matrix(:,7);
end

scatter3(fval_matrix(:,1),fval_matrix(:,2),fval_matrix(:,3), 100,colorvec, 'fill')
% surf(fval_matrix(:,1),fval_matrix(:,2),fval_matrix(:,3))

hold on
add_inter_sphere()

% hold on
% one_vector = [1.1,1.9,0];
% vector = one_vector*1.4;
% line([0,2],[0,4],[0,1], 'LineWidth', 4)

end

