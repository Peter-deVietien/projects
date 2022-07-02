function a=getAcc(pos,Nx,boxsize,n0,Gmtx,Lmtx)


N = numel(pos);
dx = boxsize/Nx;

j=floor(pos/dx);
jp1=j+1;

weight_j = (jp1*dx - pos)/dx;
weight_jp1 = (pos - j*dx)/dx;

j = mod(j,Nx);
jp1 = mod(jp1,Nx);

n=[];
for i=0:Nx-1
    sel=j==i;
    n(i+1)=sum(weight_j(sel));
    
    sel=jp1==i;
    n(i+1)=n(i+1)+sum(weight_jp1(sel));
end


n=n*n0*boxsize/N/dx;;
n=n(:);

%%

phi_grid=Lmtx\(n-n0);
phi_grid=phi_grid(:);

E_grid = -Gmtx*phi_grid;

E = weight_j.*E_grid(j+1) + weight_jp1.*E_grid(jp1+1);

a=-E;