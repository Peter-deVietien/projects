cca

[gdates,gprice]=load_gold_historical_prices_usd;
[sdates,sprice]=load_silver_historical_prices_usd;


%%
[spdates,spgp]=dspline(gdates,gprice,sdates);
ratio=spgp./sprice;

%%

lw=1.5;

plot(spdates,ratio,'linewidth',lw);

hold on
plot([spdates(1) spdates(end)],[1 1]*ratio(end),'linewidth',0.5)
hold off

fig=gcf;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

ax=gca;
ax.FontSize=14;
ax.YGrid='on';
yticks=[0:20:140];
ax.YTick=yticks;

y_lim=[0 140];
ylim(y_lim);

yyaxis right

ax=gca;
ax.YTick=yticks;
ylim(y_lim);
ax.YAxis(2).Color='k';
%%

title(['Price of gold in ounces of silver'])

%%
t1=text(0.714,0.0382,['Last Date: ',datestr(spdates(end),'dd-mmm-yyyy')],'fontsize',12,'units','normalized');
t2=text(-0.0177,-0.1085,'Twitter: @peterdevietien   Data: MacroTrends','fontsize',11,'units','normalized');

xlim([spdates(1) spdates(end)+calyears(1)])

%%

print('~/projects/stock/post/gold_silver_ratio','-dpng')