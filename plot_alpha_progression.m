function [] = plot_alpha_progression(C, prefix, muscles_of_interest)
	% @param C a cell array, where C{1,:} are numeric alpha values
	% C{2,:} and C{3,:} are lowerbound and upperbound matrices.
	% Each lower/upper bound matrix has (6(endpoint axes)+n_muscles) columns
	% Each matrix has (n_unitvectors) rows
C_size = size(C)
alpha_steps = C_size(2)
bound_names = ['lower'; 'upper']
for muscle_number=muscles_of_interest
	for bound=1:2 %both lower and upper activation bounds
			for alpha=1:alpha_steps
			
			alphaval = C{1,alpha}
			% Set file name e.g. muscle_1_alpha_2_upperbound.pdf
			file_string =  ['figs/' prefix '_muscle' '_' num2str(muscle_number) '_' ...
							'alphapercent' '_' num2str(alphaval*100) '_' bound_names(bound,:) 'bound'] ;
			task_scatter(C{bound+1,alpha},muscle_number,false);
			% Append the alpha percentage string to the figure title
			title_str = ' '
			pdf_task_scatter(title_str, file_string);
            
	end
end
end