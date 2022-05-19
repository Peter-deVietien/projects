cca

t=readtable('~/projects/societal/data/female_suicide_rates_cdc.csv');

dates=datetime(t.Var1,1,1);
suicide_10_14=t.Var3;