function [dates,marketcap]=load_oih_market_cap

t=readtable('~/projects/stock/data/oih_market_cap.csv');

dates=t.Var1;
marketcap=t.Var2;

figure;
plot(dates,marketcap)
