% @param fval_mat columns 123 are xyz, column 7 is fval.
% @output unitvec the direction unit vector which yielded the lowest fval
function [ unitvec ] = min_dir( fval_mat )
	[a,b] = min(fval_mat(:,7));
	unitvec = fval_mat(b,1:3);
end