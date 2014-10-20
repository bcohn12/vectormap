% @param fval_mat columns 123 are xyz, column 7 is fval.
% @output unitvec the direction unit vector which yielded the highest fval.
function [ unitvec ] = max_dir( fval_mat )
	[a,b] = max(fval_mat(:,7));
	unitvec = fval_mat(b,1:3);
end