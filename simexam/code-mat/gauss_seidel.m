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


phi_left=0;
phi_right=0;

max_it=500;

for k=1:max_it
   for i=2:ni-1
       phi(i)=(phi(i-1) + phi(i+1) + (dx*dx)*rho(i)/EPS_0)/2;
   end
   
end

phi