function [] = alpha_progression(C)
for alpha=1:5
	for bound=1:2
		bound_names = ['lower'; 'upper']
		file_string = ['alpha' '_' num2str(alpha) '_' bound_names(bound,:) 'bound'] %e.g. alpha_1_upperbound.pdf
		disp(file_string)
		task_scatter(C{bound+1,alpha},1,false)
		title(C{1,alpha}) %append the alpha percentage string to the figure title
		set(gcf, 'PaperPosition', [-0.5 -0.25 6 5.5]); %Position the plot further to the left and down. Extend the plot to fill entire paper.
		set(gcf, 'PaperSize', [5 5]); %Keep the same paper size
		saveas(gcf, file_string, 'pdf')
	end
end
end