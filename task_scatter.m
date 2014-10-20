function [] = task_scatter( task_matrix, muscle_number, log_transform )
%fval_matrix, where the first 6 columns define the task vector. each row is
%a task
%muscle_number integer, from 1 to n muscles.
%log_transform (boolean) if true, it will perform a log10 transformation to
%the data.
%takes in a muscle matrix, where the first three columns are XYZ values,
%and the 12th and up columns are muscles 1 through n
	if log_transform
	    colorvec = log10(task_matrix(:,muscle_number+6));
	else
	    colorvec = task_matrix(:,muscle_number+6);
	end
	scatter3(task_matrix(:,1),task_matrix(:,2),task_matrix(:,3), 100,colorvec, 'fill')
	hold on
	add_inter_sphere()

end
