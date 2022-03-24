load_usa_age_data

cspop=[0; cumsum(pop_age)];

pp=spline([0; ages],cspop);
ppages=[0:1:100];

pppop=ppval(pp,ppages);

pop_bins=max(0,pppop(2:end)-pppop(1:end-1));
pop_bins=round(pop_bins,0);

%bar(ppages(2:end),pop_bins)

