    %% Load Paxlovid Data
    %%
    lof.L=100*1000;
    lof.x0=85;
    lof.k=.04;
    lof.x=[-30:270];
    lof.t0=datetime(2022,1,1);
    lof.t=lof.t0+lof.x;

    %%
    lof.f=lof.L./(1+exp(-lof.k.*(lof.x-lof.x0)));