function [ fval_mat ] = vectormap_2D(RFm, J, plane, n)
	% Generate a 2-dimensional slice of the vectormap in two dimensions. 
	% Creates a colored circle on points intersecting two of the dimensions.
	% @param RFm RFm matrix
	% @param J Jacobian matrix
	% @param n Number of vectors to be generated (uniformly) and evaluated
	% @param plane string The two dimensions represented in the plane. 'xy','yz' or 'xz'
	[circle_dim1,circle_dim2] = gen_xy_circle(n);
	%define the task-vectors based on the plane of choice
	switch plane
		%put zeros in for all dimensions not in the plane of interest
	    case 'xy'
	        task_vector_matrix=[circle_dim1, circle_dim2, zeros(n,1),... %forces of xyz
	                            zeros(n,1), zeros(n,1), zeros(n,1)];    %torques of xyz
	    case 'yz'
	    	task_vector_matrix=[zeros(n,1), circle_dim1, circle_dim2,... %forces of xyz
	                            zeros(n,1), zeros(n,1), zeros(n,1)];     %torques of xyz
	    case 'xz'
	    	task_vector_matrix=[circle_dim1, zeros(n,1), circle_dim2,... %forces of xyz
	                            zeros(n,1), zeros(n,1), zeros(n,1)];   %torques of xyz
	end
	fval_mat = [task_vector_matrix,zeros(n,1)];
	for row = 1:n
		Fend = task_vector_matrix(row,:)';
		[ magnitude, activation_vec ] = get_magnitude_model_input(Fend, RFm, J);
		fval_mat(row,7) = magnitude;
    end
    scatter(circle_dim1, circle_dim2, 500, fval_mat(:,7), 'filled')
    pbaspect([1,1,1])
    colorbar
    xlim([-1.2 1.2])
    ylim([-1.2 1.2])

