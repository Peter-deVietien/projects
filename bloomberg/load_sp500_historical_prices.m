function [dates,price_no_div,price_div]=load_sp500_historical_prices()

%%
warning('off','MATLAB:table:ModifiedAndSavedVarnames')
td=readtable('data/sp500_cumulative_return_dividends.csv');
td=sortrows(td);

tp=readtable('data/sp500_historical_price.csv');
tp=sortrows(tp);


%%
dates=td.Var1;
price_no_div=tp.Var2;
price_div=tp.Var2(1)*(td.Var2+100)/100;