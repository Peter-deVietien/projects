cca

%%
ticker='^GSPC';
d=load_ticker_data(ticker);
dates=d.dates_close;
price=d.close;

[gdates,gprice]=load_gold_historical_prices_usd;

%% get common dates

[~,cprice]=dspline(gdates,gprice,dates);

%%
leftycolor=[0 0.4470 0.7410];
rightycolor=[0.8500 0.3250 0.0980];

fig=figure;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

p(1)=plot(dates,price./cprice,'linewidth',1,'color',leftycolor);

%%
grid on
ax=gca;
ax.FontSize=15;

title(['S&P 500 in ounces of Gold'],'Fontsize',18)

ax.XGrid='off';


xlim([datetime(1949,1,1) datetime(2024,1,1)])


t1=text(0.3223,-0.1161,'Truth Social: @pdv   Twitter: @peterdevietien    Data: Bloomberg','fontsize',11,'units','normalized');

%%
print('~/projects/stock/post/sp500_vs_gold','-dpng')