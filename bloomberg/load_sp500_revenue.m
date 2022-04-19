function [dates,revenue]=load_sp500_revenue()

%%
warning('off','MATLAB:table:ModifiedAndSavedVarnames')
t=readtable('data/sp500_revenue.csv','Format','%{MM/dd/yyyy}D%f');
t=sortrows(t);

%%
sind=22;
dates=t.Var1(sind:end);
revenue=t.Var2(sind:end)/1e9;