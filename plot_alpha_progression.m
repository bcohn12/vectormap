function [] = plot_alpha_progression(C)
	% @param C a cell array, where C{1,:} are numeric alpha values
	% C{2,:} and C{3,:} are lowerbound and upperbound matrices.
	% Each lower/upper bound matrix has (6(endpoint axes)+n_muscles) columns
	% Each matrix has (n_unitvectors) rows
C_size = size(C)
alpha_steps = C_size(2)
bound_names = ['lower'; 'upper']
for muscle_number=1:31
	for bound=1 %only look at lower bound
			for alpha=1:alpha_steps
			
			alphaval = C{1,alpha}
			% Set file name e.g. muscle_1_alpha_2_upperbound.pdf
			file_string =  ['figs/muscle' '_' num2str(muscle_number) '_' ...
							'alphapercent' '_' num2str(alphaval*100) '_' bound_names(bound,:) 'bound'] 
			task_scatter(C{bound+1,alpha},muscle_number,false)
			% Append the alpha percentage string to the figure title
			title(['muscle ' num2str(muscle_number) 'alpha' num2str(alphaval) ' ' bound_names(bound,:) 'bound']) 
			% Position the plot further to the left and down. 
			set(gcf, 'PaperPosition', [-0.5 -0.25 6 5.5]); 
			% Extend the plot to fill entire paper.
			set(gcf, 'PaperSize', [5 5]); %Keep the same paper size
			saveas(gcf, file_string, 'pdf')
			close
	end
end
end