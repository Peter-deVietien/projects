function [dates,rates]=load_us_housing_price_fhfa()

%%
warning('off','MATLAB:table:ModifiedAndSavedVarnames')
t=readtable('data/us_housing_price_fhfa.csv');
t=sortrows(t);

%%
dates=t.Date;
rates=t.LastPrice;