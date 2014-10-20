function [ meanmatrix ] = vectormap_mean( cat1,cat2,cat3 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
output_mat = cat1;
colnum = length(cat1(:,1));
samplenum = length(cat1);
for col = 7:42
    for sample=1:samplenum
        %get the average
        first = cat1(sample, col);
        second = cat2(sample,col);
        third = cat3(sample,col);
        output_mat(sample, col) = mean([first, second, third]);
        
    end
end
meanmatrix = output_mat

end

