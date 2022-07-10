function [dates,price_no_div,price_div]=load_sp500_historical_prices()

%%
warning('off','MATLAB:table:ModifiedAndSavedVarnames')
td=readtable('../data/sp500_cumulative_return_dividends.csv');
td=sortrows(td);

tp=readtable('../data/sp500_historical_price.csv');
tp=sortrows(tp);


%%
dates=td.Var1;
price_no_div=tp.Var2;
price_div=tp.Var2(1)*(td.Var2+100)/100;

%%
ratio=price_div./price_no_div;
rat_days=1000;

ndays=days(dates(end-rat_days:end)-dates(end));

pp=polyfit(ndays,ratio(end-rat_days:end),1);

%%


ticker='^GSPC';
d=load_ticker_data(ticker);
ndates=d.dates_close;
nprice=d.close;

ind=find(ndates>dates(end),1,'first');
add_days=days(ndates(ind:end)-dates(end));

div_coef=pp(2)+pp(1)*add_days;

%%
price_div=[price_div;nprice(ind:end).*div_coef];
price_no_div=[price_no_div;nprice(ind:end)];
dates=[dates;ndates(ind:end)];