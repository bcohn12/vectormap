function [MAT] = mat_from_1d_csv()
    xyz_1d = readtable('python_implementation\uniform_grid_xyz.csv', 'ReadVariableNames',false);    
    xyz = table2array(xyz_1d);
    n = length(xyz)/3;
    MAT = zeros(n,6);
    x = xyz(1:n);
    y = xyz(n+1:2*n) ;
    z = xyz(2*n+1:end);
    scatter3(x,y,z)
    for row = 1:(n)
        MAT(row, 1) = x(row);
        MAT(row, 2) = y(row);
        MAT(row, 3) = z(row);
        %torques are all set to zero
    end
    
end