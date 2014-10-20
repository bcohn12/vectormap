function [] = muscle_scatter( fval_matrix, muscle_number, log_transform )
%takes in a muscle matrix, where the first three columns are XYZ values,
%and the 12th and up columns are muscles 1 through n
	if log_transform
	    colorvec = log10(fval_matrix(:,muscle_number+11));
	else
	    colorvec = fval_matrix(:,muscle_number+11);
	end
	scatter3(fval_matrix(:,1),fval_matrix(:,2),fval_matrix(:,3), 100,colorvec, 'fill')
	hold on
	add_inter_sphere()

end

