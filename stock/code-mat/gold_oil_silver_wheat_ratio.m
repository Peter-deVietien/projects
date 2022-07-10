cca

[gdates,gprice]=load_gold_historical_prices_usd;
[sdates,sprice]=load_silver_historical_prices_usd;

addpath('../../eia/code-mat')
[a,b]=load_eia_series('PET.RBRTE.W');
od=process_weekly_data(a);

odates=od.dates;
oprice=od.y;

d=load_ticker_data('ZW=F');

wdates=d.dates_close;
wprice=d.close();

%%
[spdates,spgp]=dspline(gdates,gprice,sdates);
sratio=sprice./spgp;

[opdates,spgp]=dspline(gdates,gprice,odates);
oratio=oprice./spgp;

[wpdates,spgp]=dspline(gdates,gprice,wdates);
wratio=wprice./spgp;


%% Normalize

oind=find(opdates(1)<spdates,1,'first');
wind=find(wpdates(1)<spdates,1,'first');

sratio=sratio/sratio(oind);

oratio=oratio/oratio(1)*sratio(oind);
wratio=wratio/wratio(1)*sratio(oind);

%%

lw=1.5;

plot(spdates,sratio,'linewidth',lw);
hold on
plot(opdates,oratio,'linewidth',lw)
plot(wpdates,wratio,'linewidth',lw)
hold off


fig=gcf;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

ax=gca;
ax.FontSize=14;
ax.YGrid='on';
yticks=[-0.5:0.5:4];
ax.YTick=yticks;

y_lim=[-0.5 4];
ylim(y_lim);

yyaxis right

ax=gca;
ax.YTick=yticks;
ylim(y_lim);
ax.YAxis(2).Color='k';
%%

title(['Price of Silver, Oil and Wheat relative to Gold'])

legend('Silver','Oil','Wheat','fontsize',15)

%%
t1=text(0.714,0.0382,['Last Date: ',datestr(spdates(end),'dd-mmm-yyyy')],'fontsize',12,'units','normalized');
t2=text(-0.0177,-0.1085,'Twitter: @peterdevietien   Data: MacroTrends','fontsize',11,'units','normalized');

xlim([datetime(1985,1,1) spdates(end)+calyears(1)])

%%

print('~/projects/stock/post/gold_oil_silver_wheat_ratio','-dpng')