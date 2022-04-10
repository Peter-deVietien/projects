function [dates,markcap]=load_sp500_energy_markcap()

%%
warning('off','MATLAB:table:ModifiedAndSavedVarnames')
t=readtable('data/sp500_energy_markcap.csv');
t=sortrows(t);

%%
dates=t.Var1(34:end);
markcap=t.Var2(34:end);