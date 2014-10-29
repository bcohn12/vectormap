function [ output_args ] = add_inter_sphere( )
%Paints a black sphere where the radius is 0.97
[X,Y,Z] = sphere(200);
X = X*.97;
Y = Y*.97;
Z = Z*.97;
surf(X,Y,Z)

end

