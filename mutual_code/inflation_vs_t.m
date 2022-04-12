function [dates,infl]=inflation_vs_t(dates)

if ispc
    t=readtable('C:\Users\pdevi\Documents\GitHub\projects\mutual_code\CPIAUCSL.csv');
else
    t=readtable('~/projects/mutual_code/CPIAUCSL.csv');
end

cpi=t.CPIAUCSL;

k={datetime(2022,3,1),cpi(end)^2/cpi(end-1)};
k=[k;{datetime(2022,4,1),k{2}^2/cpi(end)}];

t=[t;k];

%%

idate=t.DATE;
infl=t.CPIAUCSL/t.CPIAUCSL(end);

if dates(1)<idate(1)
    error('Inflation input date preceeds inflation data range')
end

ddays=days(dates(1)-idate(1));
sdays=days(dates-dates(1));

sidays=days(idate-idate(1))-ddays;

infl=spline(sidays,infl,sdays);
