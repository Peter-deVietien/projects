function [dx,dy,dz]=getPairwiseSeparations(ri,rj)

M = size(ri,1);
N = size(rj,1);

rix = ri(:,1);
riy = ri(:,2);
riz = ri(:,3);

rjx = rj(:,1);
rjy = rj(:,2);
rjz = rj(:,3);

dx = rix - rjx';
dy = riy - rjy';
dz = riz - rjz';