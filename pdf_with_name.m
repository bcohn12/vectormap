function [  ] = pdf_with_name( stringname )
set(gcf, 'PaperPosition', [0 0 5 5]); %Position the plot further to the left and down. Extend the plot to fill entire paper.
set(gcf, 'PaperSize', [5 5]); %Keep the same paper size
saveas(gcf, stringname, 'png');

end

