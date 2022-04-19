function mboe=quadbtu_to_mboe(qbtu)

joules=btu_to_kwh(qbtu*1e15)*3600*1000;
j_per_boe = 6.118e9;

boe=joules/j_per_boe;
mboe=boe/1e6;

