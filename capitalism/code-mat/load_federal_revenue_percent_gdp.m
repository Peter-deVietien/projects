function [year,percent_gdp,population]=load_federal_revenue_percent_gdp

warning('off','MATLAB:table:ModifiedAndSavedVarnames')
t=readtable('~/projects/capitalism/data/federal_revenue_percent_gdp.csv','range','2:233');

year=datetime(t.USFederalRevenueSinceTheFounding,7,1);
percent_gdp=t.Var4;
population=t.Var3*1e6;