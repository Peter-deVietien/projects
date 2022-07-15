%function [phi] = tridiag(dx,phi,rho)
cca

QE = 1.602176565e-19;	  % C, electron charge
EPS_0 = 8.85418782e-12;   % C/V/m, vacuum perm.
ME = 9.10938215e-31;	  % kg, electron mass


ni=21;
x0 = 0;
xd = 0.1;
dx = (xd-x0)/(ni-1);

rho=ones(ni,1)*QE*1e12;
phi=zeros(ni,1);


a=zeros(ni,1);
b=zeros(ni,1);
c=zeros(ni,1);
d=zeros(ni,1);

%%
for i=1:ni
    if i==1 | i==ni
        b(i) = 1;
        d(i) = 0;
    else
        a(i) = 1/(dx*dx);
        b(i) = -2/(dx*dx);
        c(i) = 1/(dx*dx);
        d(i) = -rho(i)/EPS_0;
    end
end

c(1) = c(1)/b(1);
d(1) = d(1)/b(1);

for i = 2:ni
    if i < ni
        c(i) = c(i) / (b(i) - a(i) *c(i-1));
    end

    d(i) = (d(i) - a(i)*d(i-1))/(b(i) - a(i)*c(i-1));
end

phi(ni)=d(ni);
for i=(ni-1):-1:1
    phi(i) = d(i) - c(i)*phi(i+1);
end
    


phi