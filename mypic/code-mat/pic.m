cca


N=4000;
Nx=400;
t=0;
tEnd=100;
dt=1;
Nt=ceil(tEnd/dt);
boxsize=50;
n0=1;
vb=3;
vth=1;
A=0.1;

dx=boxsize/Nx;

pos=rand(N,1)*boxsize;
vel = vth * rand(N,1) + vb;
Nh=floor(N/2);
vel(1:Nh)= vel(1:Nh)*-1;
vel = vel.*(1+A*sin(2*pi*pos/boxsize));




pgradient;
plaplacian;

acc = getAcc(pos, Nx, boxsize, n0, Gmtx, Lmtx);

for i =1:Nt
    vel = vel + acc * dt/2;
    
    pos = pos + vel * dt;
    pos = mod(pos,boxsize);
    
    acc = getAcc(pos, Nx, boxsize, n0, Gmtx, Lmtx);
    
    vel = vel + acc * dt/2;
    
    t = t+dt;
    
    scatter(pos(1:Nh),vel(1:Nh),'r.')
    hold on
    scatter(pos(Nh:end),vel(Nh:end),'b.')
    hold off
    ylim([-10 10])
    drawnow
    pause(0.1)
end