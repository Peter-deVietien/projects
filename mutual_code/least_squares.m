function [yo,mo,x,bo]=least_squares(x,y)

x=x(:);
y=y(:);

nx = numel(x);
xsq = x.^2;
xy = x.*y;

sumx = sum(x);
sumy = sum(y);
sumxsq = sum(xsq);
sumxy = sum(xy);

mo = (nx*sumxy - sumx*sumy) / (nx*sumxsq - sumx^2);

bo = (sumy - mo*sumx) / nx;

yo = mo * x + bo;
