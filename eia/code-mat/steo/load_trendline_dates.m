function [fit]=load_trendline_dates(sdates,polynum)

sdate=datetime(2020,7,15);
edate=datetime(2021,12,1);
sind=find(dates>sdate,1,'first');
eind=find(dates>edate,1,'first');

nd=numel(dates(sind:eind));

pf=polyfit([1:nd],inven(sind:eind),polynum);

fit=polyval(pf,[(1-3):(nd+3)]);
fitx=[(dates(sind)-calmonths(3)):calmonths(1):(dates(eind)+calmonths(3))];

%%
fit.x=fitx;
fit.y=fit;