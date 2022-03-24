cca

ticker='OXY';
plt_color='b';
plot_price;
load_ticker_data
ma_days=365*3;
overlay_moving_average

ticker='CL=F';
plt_color=[0.9290, 0.6940, 0.1250];
overlay_price
overlay_moving_average

sprice=price;
ticker='CLZ21.NYM';
load_ticker_data

f_dates=dates(end):1:datetime(2021,12,01);
f_price=linspace(sprice(end),price(end),numel(f_dates));

npl=numel(h);
hold on
h(npl+1)=plot(f_dates,f_price,'linewidth',3);
hold off
lgs=[lgs {sprintf('Dec 2021 Futures')}];

%%
grid on

legend(h,lgs,'autoupdate','off')

hold on
plot([datetime(2008,11,01) datetime(2008,11,01)],[-100 300],'k--','linewidth',3)
plot([datetime(2012,11,01) datetime(2012,11,01)],[-100 300],'k--','linewidth',3)
plot([datetime(2016,11,01) datetime(2016,11,01)],[-100 300],'k--','linewidth',3)
plot([datetime(2020,11,01) datetime(2020,11,01)],[-100 300],'k--','linewidth',3)
hold off

ylim([0 150])
xlim([datetime(2000,01,01) datetime(2022,01,01)])

fig=gcf;
fig.Position=[50 150 1200 600];

title_str=sprintf('OXY and Oil Futures, Dec 2021 at $%.2f',price(end));
title(title_str)

ax=gca;
ax.FontSize=20;