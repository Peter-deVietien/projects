function a=getAcc(pos,vel,m,h,k,n,lmbda,nu)

N=size(pos,1);

rho = getDensity(pos,pos,m,h);

P = getPressure(rho,k,n);

[dx,dy,dz]=getPairwiseSeparations(pos,pos);

[dWx, dWy, dWz] = gradW( dx, dy, dz, h);

ax = -sum(m * ( P./rho.^2 + P'./rho'.^2 ) .* dWx,2);
ay = -sum(m * ( P./rho.^2 + P'./rho'.^2 ) .* dWy,2);
az = -sum(m * ( P./rho.^2 + P'./rho'.^2 ) .* dWz,2);

a=[ax,ay,az];

a = a - lmbda * pos;
a = a - nu * vel;
