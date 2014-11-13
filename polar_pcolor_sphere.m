n = 6;
r = (0:n)'/n;
theta = pi*(-n:n)/n;
X = r*cos(theta);
Y = r*sin(theta);
[x,y]= gen_xy_circle(n)
C = r*cos(2*theta);
pcolor(X,Y,C)
axis equal tight