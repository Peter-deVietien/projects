cca

%%
ticker='UKX-USD';
eu=load_ticker_data(ticker);

ticker='^GSPC';
us=load_ticker_data(ticker);

[gdates,gprice]=load_gold_historical_prices_usd;

%% get common dates

[~,euprice]=dspline(gdates,gprice,eu.dates_close);

[~,usprice]=dspline(gdates,gprice,us.dates_close);



%%
leftycolor=[0 0.4470 0.7410];
rightycolor=[0.8500 0.3250 0.0980];

fig=figure;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

p(1)=plot(us.dates_close,us.close./usprice,'linewidth',1,'color',leftycolor);
hold on
p(2)=plot(eu.dates_close,eu.close./euprice,'linewidth',1,'color',leftycolor);
hold off
%%
grid on
ax=gca;
ax.FontSize=15;

title(['S&P 500 in ounces of Gold'],'Fontsize',18)

ax.XGrid='off';


xlim([datetime(1949,1,1) datetime(2024,1,1)])


t1=text(0.3223,-0.1161,'Truth Social: @pdv   Twitter: @peterdevietien    Data: Bloomberg','fontsize',11,'units','normalized');

%%
print('~/projects/stock/post/sp500_euro_vs_gold','-dpng')