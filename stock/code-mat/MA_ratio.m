cca
set(0,'defaultlinelinewidth',1)

%%
ticker='OXY';
plt_color='b';
load_ticker_data

ma_days=365*3;

v_ma=moving_average(dates_full,price,ma_days);

%%
ratio=price./v_ma;
plot(dates_full,moving_average(dates,ratio,3))

hold on
plot([dates_full(1) dates_full(end)],[1 1],'k-')
hold off


fig=gcf;
fig.Position=[200 211 1046 552];

grid on

ylabel('Price/MA')

tstr=sprintf('Ratio of Price to %d Day Moving Average',ma_days);
title(tstr)


ax=gca;
ax.FontSize=20;

figure
smooth_ratio=moving_average(dates_full,ratio,100);
%smooth_price=moving_average(dates_full
plot(dates_full,gradient(smooth_ratio))