function [rho] = getDensity(r,pos,m,h)

M = size(r,1);

[dx,dy,dz] = getPairwiseSeparations(r,pos);

rho = sum(m * W(dx,dy,dz,h),2);
rho=rho(:);