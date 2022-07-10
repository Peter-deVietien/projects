cca

%% Evolve particle on mesh

%% Set up mesh
xg=linspace(-10,10,10);
yg=linspace(-10,10,10);
zg=linspace(-10,10,10);

[gx,gy,gz]=meshgrid(xg,yg,zg);

%bx=ones(size(gx)).*linspace(0,10,20)';
%bx=ones(size(gx));
%by=ones(size(gx));
bz=zeros(size(gx));

gr=sqrt(gx.^2+gy.^2);

theta=atan2d(-gx,gy)+180;

bx=cosd(theta)*50./gr;
by=sind(theta)*50./gr;

%quiver3(gx,gy,gz,bx,by,bz)

%%


nt=1000;
dt=1/300;
m=1;

x=nan(nt,1);
y=nan(nt,1);
z=nan(nt,1);

x(1)=5;
y(1)=0;
z(1)=0;

vx=10;
vy=10;
vz=0;

% F = v cross B 

% Find bx,by,bz at x,y,z


fig=figure;
fig.Position=[199 148 837 718];

vct=-10;

fx=0;
fy=0;
fz=0;

e0=sum(1/2*m*sqrt(vx^2+vy^2+vz^2));

for i=1:nt

    bxp=interp3(gx,gy,gz,bx,x(i),y(i),z(i));
    byp=interp3(gx,gy,gz,by,x(i),y(i),z(i));
    bzp=interp3(gx,gy,gz,bz,x(i),y(i),z(i));

    fx1=vy*bzp - vz*byp;
    fy1=vz*bxp - vx*bzp;
    fz1=vx*byp - vy*bxp;
    
    vx1=vx+(fx1+fx)/2/m*dt;
    vy1=vy+(fy1+fy)/2/m*dt;
    vz1=vz+(fz1+fz)/2/m*dt;
    
    fx=fx1;
    fy=fy1;
    fz=fz1;
    
    x(i+1)=x(i)+(vx1+vx)/2*dt;
    y(i+1)=y(i)+(vy1+vy)/2*dt;
    z(i+1)=z(i)+(vz1+vz)/2*dt;
    
    vx=vx1;
    vy=vy1;
    vz=vz1;
    
    e=sum(1/2*m*sqrt(vx^2+vy^2+vz^2));
    
    vx=vx*e0/e;
    vy=vy*e0/e;
    vz=vz*e0/e;
    
    %%
    p=quiver3(gx,gy,gz,bx,by,bz);
    alpha(0.1)
    hold on
    if i>1
        scatter3(x,y,z,20,'filled','markerfacecolor',[0 0 0])
    end
    scatter3(x(i),y(i),z(i),100,'filled')
    hold off
    
    xlabel('x')
    ylabel('y')
    zlabel('z')
    
    xlim([-12 12])
    ylim([-12 12])
    
    ax=gca;
    ax.View(1)=vct;
    vct=vct-.15;
    %ax.View=[0.8416   90.0000]
    
    drawnow
    %pause(0.01)
    
end

