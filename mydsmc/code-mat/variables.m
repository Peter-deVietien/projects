uw = 5;
Tw = .5;
n0 = 0.001;
N = 50000;
Nsim = 1;
Ncell = 5;
Nmft = 400;

Nt = Nmft*25;

lambda_mfp = 1/(sqrt(2)*pi*n0);
Lz = 10*lambda_mfp;
Kn = lambda_mfp / Lz;
v_mean = (2/sqrt(pi))*sqrt(2*Tw);
tau = lambda_mfp / v_mean;
dt = Nmft*tau/Nt;
dz = Lz/Ncell;
vol = Lz * dz * dz / Ncell;
Ne = n0 * Lz * dz * dz / N;
