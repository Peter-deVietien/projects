

ticker='OIH';

%%
d=load_ticker_data(ticker);

%%
h=plot(d.dates_full,d.price,'linewidth',2);

%%
ax=gca;
ax.FontSize=20;
ax.YTick=[0:100:1400];
grid on

fig=gcf;
fig.Position=[100 100 500 750];

text(datetime(2018,1,1),600,'$OIH','fontsize',20)

ylabel('Stock Price')