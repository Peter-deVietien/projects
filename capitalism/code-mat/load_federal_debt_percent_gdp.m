function [year,percent_gdp]=load_federal_debt_percent_gdp

warning('off','MATLAB:table:ModifiedAndSavedVarnames')
t=readtable('~/projects/capitalism/data/federal_debt_perc_gdp.csv','range','2:233');

year=datetime(t.Var1,7,1);
percent_gdp=t.Var4;
