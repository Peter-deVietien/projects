clear;
close all;

c=blp;

format bank

sec= 'CL1 COMB Comdty';
fields={'LAST_PRICE','OPEN'};

fromdate='1/01/2000';
todate=datestr(today,'mm/dd/yyyy');
period='daily';

[dwti,sec]=history(c,sec,fields,fromdate,todate,period);

dateswti=datetime(datevec(dwti(:,1)));




sec= 'OISTCRDE Index';
fields={'LAST_PRICE','OPEN'};

fromdate='1/01/2000';
todate=datestr(today,'mm/dd/yyyy');
period='daily';

[doi,sec]=history(c,sec,fields,fromdate,todate,period);

datesoi=datetime(datevec(doi(:,1)));


p1=plot(dateswti,dwti(:,2),'linewidth',2);
p1.Color(4)=0.5;

yticks=[50:10:130];
ax=gca;
ax.YTick=yticks;

ylabel('WTI [$/bbl]')

yyaxis right

p2=plot(datesoi,doi(:,2),'linewidth',2);
p2.Color(4)=0.5;

ylabel('Open Interest CL1')

%%
fig=gcf;
fig.Position=[488.00 304.20 947.40 457.80];

grid on

ax=gca;
ax.YAxis(1).Color=p1.Color;
ax.YAxis(2).Color=p2.Color;
ax.XGrid='off';
ax.FontSize=16;
ax.Position=[0.11 0.14 0.78 0.79];

xl=xlim;
xlim([datetime(2021,1,1) xl(2)+calmonths(1)])

text(0.735,0.02,sprintf('Data includes: %s',datestr(datesoi(end),'mmm dd yyyy')),'fontsize',11,'units','normalized')
text(0.52,-0.13,'Twitter: @peterdevietien   Data: Bloomberg','fontsize',14,'units','normalized')

close(c)

print('post/cl1_oi','-dpng')