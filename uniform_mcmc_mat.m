%@param upper_mat and lower_mat need to be the same size matrices.
function [ mc_mat ] = uniform_mcmc_mat(lower_mat, upper_mat)
	mc_mat = zeros(size(upper_mat));
    s = size(upper_mat);
	for row = 1:s(1),
		for col = 1:s(2),
			cell_value = lower_mat(row,col) + ...
			(upper_mat(row,col)-lower_mat(row,col)).*rand(1,1);
			% disp(cell_value)
			mc_mat(row,col) = cell_value; %plug in the cell value	
end
end
end