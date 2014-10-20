function [ std_matrix ] = vectormap_std( cat1,cat2,cat3 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
output_mat = cat1;
colnum = length(cat1(:,1));
samplenum = length(cat1);
for col = 7:42
    for sample=1:samplenum
        %get the sd
        output_mat(sample, col) = std([cat1(sample, col), ...
            cat2(sample,col), cat3(sample,col)]);
    end
end
std_matrix = output_mat

end

