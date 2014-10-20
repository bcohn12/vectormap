function [ vec ] = number_among_zeros( number, index_to_place_number, length )
%input the length of the vector, and the index where it will put a given 'number'.
%outputs a bunch of zeros, with your number placed in the given index.
%author Brian Cohn May 29, 2014 brian_cohn14@pitzer.edu
    vec = zeros(length,1);
    vec(index_to_place_number) = number;
   
end

