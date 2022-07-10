function [wx,wy,wz]=gradW(x,y,z,h)

r = sqrt(x.^2 + y.^2 + z.^2);

n = -2 * exp(-(r.^2)/(h^2)) / h^5 / pi^(3/2);

wx = n .* x;
wy = n .* y;
wz = n .* z;