

comm=17;
resi=14;

tot=comm+resi;

kwh=btu_to_kwh(tot*1e15)
joules=kwh*3600*1000;
j_per_boe = 6.118e9;

boe_pa=joules/(j_per_boe);
boe_pd=boe_pa/365