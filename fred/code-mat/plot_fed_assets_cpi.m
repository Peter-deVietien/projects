cca

[dfa,fa]=load_fred_series('WALCL');

key='CPALTT01USM659N';
[dates,cpi]=load_fred_series(key);
dates=dates+caldays(14);

%%

dates=[dates;datetime(2022,6,15)];
cpi=[cpi;9.1];

leftycolor=[0 0.4470 0.7410];
rightycolor=[0.8500 0.3250 0.0980];

lw=2;

plot(dfa,fa/1e6,'linewidth',lw,'color',leftycolor);


fig=gcf;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

ax=gca;
ax.FontSize=14;
ax.YGrid='on';
ylim([3 10])

ylabel('Federal Reserve Assets [Trillions USD]')

yyaxis right

plot(dates,cpi,'linewidth',lw,'color',rightycolor)

ylabel('CPI % YoY')

ax=gca;
ax.YAxis(1).Color=leftycolor;
ax.YAxis(2).Color=rightycolor;
%%

lgn=legend('Fed Assets','CPI');
lgn.Position=[0.1396 0.8071 0.1733 0.1024];

title('U.S. Federal Reserve Total Assets and CPI')

%%
t1=text(0.64,0.1,['CPI Last Date: ',datestr(dates(end),'dd-mmm-yyyy')],'fontsize',12,'units','normalized');
t2=text(0.63,0.0382,['Assets Last Date: ',datestr(dfa(end),'dd-mmm-yyyy')],'fontsize',12,'units','normalized');
t3=text(0.55,-0.11,'Twitter: @peterdevietien   Data: FRED','fontsize',12,'units','normalized');

%xl=xlim;
xlim([datetime(2018,1,1) datetime(2022,8,1)])

%%

print('~/projects/stock/post/fed_assets_cpi','-dpng')