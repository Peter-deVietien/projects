function [dates,rates]=load_mortgage_rates_30yr()

%%
warning('off','MATLAB:table:ModifiedAndSavedVarnames')
t=readtable('data/mortgage_rates_30yr.csv');
t=sortrows(t);

%%
dates=t.Date;
rates=t.LastPrice;