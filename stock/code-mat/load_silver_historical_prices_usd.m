function [dates,price_nom,price_real]=load_silver_historical_prices_usd()

%%
%warning('off','MATLAB:table:ModifiedAndSavedVarnames')
h=readtable('../data/mt_silver_monthly_1915_2022.csv');

hdates=h.date;
hprice_nom=h.nominal;
hprice_real=h.real;

%%
ticker='SI=F';
d=load_ticker_data(ticker);

hind=find(hdates>d.dates_close(1),1,'first');

%%

dates=[hdates(1:hind);d.dates_close];
price_nom=[hprice_nom(1:hind);d.close];

[dates,ind]=unique(dates);
price_nom=price_nom(ind);