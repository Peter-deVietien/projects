clear;
close all;

c=blp;

format bank

sec= 'CL1 COMB Comdty';
fields={'LAST_PRICE','OPEN'};

fromdate='1/01/2000';
todate=datestr(today,'mm/dd/yyyy');
period='weekly';

[d,sec]=history(c,sec,fields,fromdate,todate,period);

dates=datetime(datevec(d(:,1)));

plot(dates,d(:,2))

close(c)