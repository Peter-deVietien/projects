function [dates,sinfl]=inflation_vs_t(dates)

addpath('~/projects/fred/code-mat/')
series_key='CPIAUCSL';
[idates,values]=load_fred_series(series_key);

%%

if dates(1)<idates(1)
    warning('Inflation input date preceeds inflation data range.  Ignoring past data')
    
    ind=find(dates>idates(1),1,'first');
    dates=dates(ind:end);

end



%% Extrapolate last two months two more months to get today's data

idays=days(idates-idates(1));
pp=spline(idays,values);

gdates=[idates(end)+calmonths(1):calmonths(1):idates(end)+calmonths(2)];
gdays=days(gdates-idates(end));

growth_rate=(pp.coefs(end-1,3)+pp.coefs(end,3))/2;

gvalues=growth_rate*gdays+values(end);

edates=[idates;gdates'];
evalues=[values;gvalues'];


idate=edates;
infl=evalues/evalues(end);
%%



ddays=days(dates(1)-idate(1));
sdays=days(dates-dates(1));

sidays=days(idate-idate(1))-ddays;

sinfl=spline(sidays,infl,sdays);

%%
if 0
    plot(idates,values,'linewidth',3)
    hold on
    plot(edates,evalues)
    hold off
    
    xlim([datetime(2020,1,1) datetime(2023,1,1)])
end