function [year,percent_gdp,population]=load_local_revenue_percent_gdp

warning('off','MATLAB:table:ModifiedAndSavedVarnames')
t=readtable('~/projects/capitalism/data/local_revenue_percent_gdp.csv','range','2:233');

year=datetime(t.Var1,7,1);
percent_gdp=t.Var4;
population=t.Var3*1e6;