cca

N = 400;
t = 0;
tEnd = 30;
dt = 0.01;
M = 2;
R = 0.75;
h = 0.1;
k = 0.1;
n = 1;
nu = .775;

lmbda = 2*k*(1+n)*pi^(-3/(2*n)) * (M*gamma(5/2+n)/R^3/gamma(1+n))^(1/n) / R^2;
m = M/N;
pos=randn(N,3)*1.5;
vel=zeros(size(pos));

acc = getAcc(pos,vel,m,h,k,n,lmbda,nu);

Nt = ceil(tEnd/dt);

fig=figure;
fig.Position=[171 203 865 663];
vct=39;

v = VideoWriter('~/projects/mysph/post/sph.avi');
open(v);

for i =1:Nt
    
    vel = vel + acc * dt/2;
    
    pos = pos + vel * dt;
    
    acc=getAcc(pos,vel,m,h,k,n,lmbda,nu);
    
    vel = vel + acc * dt/2;
    
    t = t + dt;
    
    p=scatter3(pos(:,1),pos(:,2),pos(:,3),'.');
    ax=gca;

    ax.XTick=[];
    ax.YTick=[];
    ax.ZTick=[];
    xlim([-1 1])
    ylim([-1 1])
    zlim([-1 1])
%     xlabel('x')
%     ylabel('y')
%     zlabel('z')
    ax.View(1)=vct;
    vct=vct-.15;
    text(0.04,-0.11,'Credit: Philip Mocz ','units','normalized')
    drawnow
    
   frame = getframe(gcf);
   writeVideo(v,frame);
    
end

close(v);