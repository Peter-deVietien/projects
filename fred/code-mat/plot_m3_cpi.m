cca

[dm3,m3]=load_fred_series('MABMM301USM189S');

key='CPALTT01USM659N';
[dates,cpi]=load_fred_series(key);
dates=dates+caldays(14);

%%

leftycolor=[0 0.4470 0.7410];
rightycolor=[0.8500 0.3250 0.0980];

lw=2;

plot(dm3,m3/1e12,'linewidth',lw,'color',leftycolor);


fig=gcf;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

ax=gca;
ax.FontSize=14;
ax.YGrid='on';


ylabel('M3 [Trillions USD]')

yyaxis right

plot(dates,cpi,'linewidth',lw,'color',rightycolor)

ylabel('CPI YoY')

ax=gca;
ax.YAxis(1).Color=leftycolor;
ax.YAxis(2).Color=rightycolor;
%%

lgn=legend('M3','CPI');
lgn.Position=[0.1475 0.7923 0.1142 0.1024];

title('U.S. M3 and CPI')

%%
t1=text(0.714,0.0382,['Last Date: ',datestr(dates(end),'dd-mmm-yyyy')],'fontsize',12,'units','normalized');
%t2=text(0.3011,0.0382,['Both curves shifted arbitrarily.  Focusing on relative growth'],'fontsize',12,'units','normalized');
t3=text(0.55,-0.11,'Twitter: @peterdevietien   Data: FRED','fontsize',12,'units','normalized');

%xl=xlim;
xlim([datetime(2018,1,1) datetime(2022,7,1)])

%%

print('~/projects/stock/post/m3_cpi','-dpng')