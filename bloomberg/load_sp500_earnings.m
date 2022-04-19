function [dates,revenue]=load_sp500_earnings()

%%
warning('off','MATLAB:table:ModifiedAndSavedVarnames')
t=readtable('data/sp500_earnings.csv','Format','%{MM/dd/yyyy}D%f');
t=sortrows(t);

%%
sind=1;
dates=t.Var1(sind:end);
revenue=t.Var2(sind:end)/1e9;