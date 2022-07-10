function w=W(x,y,z,h)

r = sqrt(x.^2 + y.^2 + z.^2);

w = (1/(h*sqrt(pi)))^3 * exp(-r.^2/h^2);