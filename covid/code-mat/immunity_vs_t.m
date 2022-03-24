cca
load_covid_age_data


deaths=c19deathbins;
totdeaths=sum(deaths);
percdeaths=deaths/totdeaths;
cumpercdeaths=cumsum(percdeaths)

ppcpdeaths=spline(ages,cumpercdeaths)
ppages=0:1:100;

% deaths=flipud(deaths);
% percdeaths=flipud(percdeaths);
% ages=flipud(ages);
ppdeaths=ppval(ppcpdeaths,ppages);

percdeaths=ppdeaths(2:end)-ppdeaths(1:end-1);
bar(ppages(2:end),percdeaths)