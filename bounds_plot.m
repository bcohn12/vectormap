function [] = bounds_plot( alpha, lower, upper, muscle_string )
% @description produce a plot with activation bounds for a given alpha.
% @param alpha, lower and upper should be equal-length vectors.
% @param muscles Vector of strings corresponding to the columns of the RFm
% matrix.
% % 
    x = alpha; % x axis is alpha
    bar(x, upper, 1, 'b', 'edgecolor', 'b');
    hold on;
    bar(x, lower, 1, 'w', 'edgecolor', 'w');
    axis([0 1 0 1]);
    hline = findobj(gcf, 'type', 'line');
    set(hline,'LineWidth',3)
    xlabel('\alpha','FontSize',8);
    ylabel('Activation','FontSize',8);
    title(muscle_string);
end

