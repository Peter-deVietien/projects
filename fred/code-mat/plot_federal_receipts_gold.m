cca

[dates,receipts]=load_fred_series('MTSR133FMS');
addpath('../../stock/code-mat')
[gdates,gprice]=load_gold_historical_prices_usd;

%%
[~,sgprice]=dspline(gdates,gprice,dates);

fig=gcf;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];


ratio=(receipts)./sgprice;

lw=1.5;

semilogy(dates,ratio,'linewidth',lw);


ax=gca;
ax.FontSize=14;
ax.YGrid='on';
yticks=[100,300,1000];
ax.YTick=yticks;

y_lim=[60 2000];
ylim(y_lim);

ylabel('Million ounces of gold')

yyaxis right

ax=gca;
ax.YTick=yticks;
ax.YScale='log';
ylim(y_lim);
ax.YAxis(2).Color='k';


ylabel('Million ounces of gold')
%%

title(['U.S. Federal Tax Revenue per month',newline,'in ounces of gold'])

%%
t1=text(0.714,0.0382,['Last Date: ',datestr(dates(end),'dd-mmm-yyyy')],'fontsize',12,'units','normalized');
t3=text(0.55,-0.11,'Twitter: @peterdevietien   Data: FRED','fontsize',12,'units','normalized');

%xl=xlim;
xlim([datetime(1980,1,1) datetime(2024,1,1)])

%%

print('~/projects/stock/post/federal_receipts_gold','-dpng')