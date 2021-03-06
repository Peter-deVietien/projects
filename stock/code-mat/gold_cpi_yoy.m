cca

[gdates,gprice]=load_gold_historical_prices_usd;


key='CPALTT01USM659N';
[dates,cpi]=load_fred_series(key);
dates=dates+caldays(14);
%%

lw=1.5;


semilogy(gdates,gprice,'linewidth',lw);

yyaxis right

plot(dates,cpi)

fig=gcf;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

ax=gca;
ax.FontSize=14;
ax.YGrid='on';
yticks=[20,35,100,200,500,1000,2000];
ax.YTick=yticks;

y_lim=[19 4000];
ylim(y_lim);

yyaxis right

ax=gca;
ax.YTick=yticks;
ax.YScale='log';
ylim(y_lim);
ax.YAxis(2).Color='k';
%%

lgn=legend('Nominal Gold/USD','Real CPI Gold/USD');
lgn.Position=[0.6433 0.3627 0.2517 0.1024];

title('Real and Nominal Gold Price in USD')

%%
t1=text(0.714,0.0382,['Last Date: ',datestr(dates(end),'dd-mmm-yyyy')],'fontsize',12,'units','normalized');
t2=text(0.55,-0.11,'Twitter: @peterdevietien   Data: FRED','fontsize',12,'units','normalized');

xlim([dates(1) dates(end)+calyears(1)])

%%

print('~/projects/stock/post/gold_cpi_yoy','-dpng')