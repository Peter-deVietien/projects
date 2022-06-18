cca

qqq=load_ticker_data('QQQ');

spy=load_ticker_data('SPY');

%%
fig=figure;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

%%
sdate=datetime(2022,4,13);

qqq.sind=find(qqq.dates_full>sdate,1,'first');
spy.sind=find(spy.dates_full>sdate,1,'first');

%%
plot([spy.dates_full(1) spy.dates_full(end)],[1 1]*100,'linewidth',2)

hold on
plot(qqq.dates_full,qqq.price/qqq.price(qqq.sind)*100,'linewidth',2)
plot(spy.dates_full,spy.price/spy.price(spy.sind)*100,'linewidth',2)
hold off

xlim([sdate-caldays(1) datetime()+caldays(5)])

%%
legend('USD','SPY','QQQ','fontsize',14)

ax=gca;
ax.YGrid='on';
ax.FontSize=14;

%%
print('~/projects/stock/post/usd_vs_spy_vs_qqq','-dpng')