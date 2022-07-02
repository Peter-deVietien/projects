

e=ones(Nx,1);

diags=[-1,1];
vals=[-e e];

Gmtx=spdiags(vals,diags,Nx,Nx);

Gmtx(end,1)=1;
Gmtx(1,end)=1;

Gmtx = Gmtx/(2*dx);

%full(Gmtx)