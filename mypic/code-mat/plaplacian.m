

e = ones(Nx,1);

diags = [-1,0,1];

vals = [e -2*e e];

Lmtx = spdiags(vals,diags,Nx,Nx);

Lmtx(end,1)=1;
Lmtx(1,end)=1;

Lmtx = Lmtx/(dx^2);


%full(Lmtx)