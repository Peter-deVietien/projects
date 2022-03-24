load_covid_age_data

%%
deaths=c19deathbins;
totdeaths=sum(deaths);
percdeaths=deaths/totdeaths;
cumpercdeaths=cumsum(percdeaths);

%%
ppcpdeaths=spline(ages,cumpercdeaths);
ppages=0:1:100;

ppdeaths=ppval(ppcpdeaths,ppages);

percdeaths=ppdeaths(2:end)-ppdeaths(1:end-1);
%bar(ppages(2:end),percdeaths)

for i=1:numel(percdeaths)
    inds=age_bin==i;
    perc_bin(inds)=percdeaths(i)/sum(inds);
end
%%
