function [dates,price]=load_gold_historical_prices_usd()

%%
%warning('off','MATLAB:table:ModifiedAndSavedVarnames')
h=readtable('../data/gold_price_1833_2018_monthly.csv');

hdates=h.dates;
hprice=h.prices;


%%
ticker='GC=F';
d=load_ticker_data(ticker);

hind=find(d.dates_close>hdates(end),1,'first');

%%

dates=[hdates;d.dates_close(hind:end)];
price=[hprice;d.close(hind:end)];

[dates,ind]=unique(dates);
price=price(ind);