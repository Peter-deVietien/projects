function [dates,infl]=inflation_vs_t(dates)

addpath('~/projects/fred/code-mat/')
series_key='CPIAUCSL';
[idates,values]=load_fred_series(series_key);

%%

idate=idates;
infl=values/values(end);

if dates(1)<idate(1)
    error('Inflation input date preceeds inflation data range')
end

ddays=days(dates(1)-idate(1));
sdays=days(dates-dates(1));

sidays=days(idate-idate(1))-ddays;

infl=spline(sidays,infl,sdays);
