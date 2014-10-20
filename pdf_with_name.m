function [  ] = pdf_with_name( stringname )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
set(gcf, 'PaperPosition', [-0.5 -0.25 6 5.5]); %Position the plot further to the left and down. Extend the plot to fill entire paper.
set(gcf, 'PaperSize', [5 5]); %Keep the same paper size
saveas(gcf, stringname, 'pdf')

end

