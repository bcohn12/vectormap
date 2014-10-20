% @param n_unitvectors An integer, which defines how many 
% vectors will be randomly chosen.
% @output taskmin xyz unit vector of the average task vector mimimized across all three cats.
% @output taskmax xyz unit vector of the average task vector maximized.
function [task_min, task_max] = 3cat_task_bounds(n_unitvectors)
	unit_vectors = random_surface_points(n_unitvectors);
	% generate vectormap databases for each cat.
	cat1_normal = fval_matrix(1,MAT, 1);
	cat2_normal = fval_matrix(2,MAT, 1);
	cat3_normal = fval_matrix(3,MAT, 1);
	% Select the minimum and maximum force capability direction 
	% among all three cats.

	%Calculate maximum task vector
	min_directions = [min_dir(cat1_normal);
					  min_dir(cat2_normal);
					  min_dir(cat3_normal)];
	task_min = average_vector(min_directions);
	task_min = task_min/norm(task_min,2);
	%Calculate maximum task vector
	max_directions = [max_dir(cat1_normal);
					  max_dir(cat2_normal);
					  max_dir(cat3_normal)];
	task_max = average_vector(max_directions);
	task_max = task_max/norm(task_max,2);


end