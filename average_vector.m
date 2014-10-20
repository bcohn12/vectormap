% @param A A matrix with n rows, each representing an xyz unit vector.
% @return unitvec A 1x3 Unit vector with the mean direction of the three vectors
function [ unitvec ] = average_vector( A )
	unitvec = sum(A)/norm(sum(A),2);
end