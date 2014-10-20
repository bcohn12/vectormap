function [ n ] = get_n_from_num_points( n_rows )
%inverse of get_num_points(n) . this is an approximation because it doesnt'
%deal with rounding up.
n = sqrt((9*n_rows)/2.0)
end

