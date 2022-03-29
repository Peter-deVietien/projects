cca;

ticker='TSLA';

d=load_ticker_data(ticker);

%%
plot(d.dates_full,d.price)

%%
ax=gca;
ax.FontSize=20;
grid on

fig=gcf;
fig.Position=[476 272 741 594];

xlim([d.dates_close(1) d.dates_close(end)+calmonths(4)])
ylim([0 1400])

yticks=[0:200:1400];
ax.YTick=yticks;
%%

a=annotation('arrow',[0.5520 0.7584],[0.5 0.2088]);

I=imread('~/projects/stock/data/elon_too_high.png');
hold on
image([300 2500]+500,[750 300]+400,I)
hold off
%%

tstr=sprintf('$TSLA Too High');
title(tstr)

%%
print('~/projects/stock/post/chart_elon_too_high','-dpng')