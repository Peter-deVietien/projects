function [dates,weight]=load_sp500_energy_percent_markcap

warning('off','MATLAB:table:ModifiedAndSavedVarnames')
d=readtable('data/sp500_energy_weight.csv');
d=sortrows(d);

dates=d.Var1;
weight=d.Var2;