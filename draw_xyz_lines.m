function [  ] = draw_xyz_lines(linewidth)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
% Your two points
one_diag = eye(3,3)*1.5;
for axis = 1:3
    P1 = one_diag(axis,:);
    P2 = one_diag(axis,:)*-1;
    % Their vertial concatenation is what you want
    pts = [P1; P2];
    % Because that's what line() wants to see    
    line(pts(:,1), pts(:,2), pts(:,3))
    % Alternatively, you could use plot3:
    plot3(pts(:,1), pts(:,2), pts(:,3), 'LineWidth',linewidth)
end






end

