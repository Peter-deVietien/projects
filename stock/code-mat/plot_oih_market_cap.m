cca

[dates,markcap]=load_oih_market_cap;

d=load_ticker_data('OIH');

%%
rightleftcolor

plot(dates,markcap/1e9,'color',leftycolor,'linewidth',2)
hold on
plot([dates(1) dates(end)],[1 1]*markcap(end)/1e9,'color',leftycolor,'linewidth',0.5)
hold off

ylim([0 450])

ylabel('OIH Members Market Cap [$bn]')

yyaxis right

plot(d.dates_full,d.price,'color',rightycolor,'linewidth',2)
hold on
plot([d.dates_full(1) d.dates_full(end)],[1 1]*d.price(end),'color',rightycolor,'linewidth',0.5)
hold off

ylabel('$OIH Price')
%%
ax=gca;
ax.YAxis(1).Color=leftycolor;
ax.YAxis(2).Color=rightycolor;
ax.FontSize=18;

grid on
ax.XGrid='off';

fig=gcf;
fig.Position=[476 394 797 472];

xlim([datetime(2012,1,1) datetime(2022,7,1)])

print('~/projects/stock/post/oih_market_cap','-dpng')