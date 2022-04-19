function [dates,revenue]=load_sp500_energy_revenue()

%%
warning('off','MATLAB:table:ModifiedAndSavedVarnames')
t=readtable('data/sp500_energy_revenue.csv');
t=sortrows(t);

%%
dates=t.Var1(34:end);
revenue=t.Var2(34:end);