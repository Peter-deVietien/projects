function P=getPressure(rho,k,n)

P = k * rho.^(1+1/n);