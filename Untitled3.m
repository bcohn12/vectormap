[x y z]=sphere(40);
tri = delaunay(x(:),y(:),z(:));
h=trisurf(tri,x,y,z); 
axis square
set(h,'FaceColor',[0 0 0], 'EdgeColor',[0.4 0.4 0.4]);
view(15,30);