clear
close all

%%
warning('off','MATLAB:table:ModifiedAndSavedVarnames')
t=readtable('data/sp500_energy_ps.csv');
t=sortrows(t);

%%
dates=t.Var1(34:end);
psratio=t.Var2(34:end);