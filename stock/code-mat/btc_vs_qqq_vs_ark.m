cca

btc=load_ticker_data('BTC-USD');

qqq=load_ticker_data('QQQ');

arkk=load_ticker_data('ARKK');

%%
fig=figure;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

%%
sdate=datetime(2021,1,1);

btc.sind=find(btc.dates_full>sdate,1,'first');
qqq.sind=find(qqq.dates_full>sdate,1,'first');
arkk.sind=find(arkk.dates_full>sdate,1,'first');

%%
plot(btc.dates_full,btc.price/btc.price(btc.sind)*100,'linewidth',2)

hold on
plot(qqq.dates_full,qqq.price/qqq.price(qqq.sind)*100,'linewidth',2)
plot(arkk.dates_full,arkk.price/arkk.price(arkk.sind)*100,'linewidth',2)
hold off

xlim([sdate-caldays(1) datetime()+calmonths(1)])

%%
legend('Bitcoin','QQQ','ARKK','fontsize',14)

ax=gca;
ax.YGrid='on';
ax.FontSize=14;

%%
print('~/projects/stock/post/btc_vs_qqq_vs_ark','-dpng')