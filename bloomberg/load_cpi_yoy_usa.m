function [dates,cpi]=load_cpi_yoy_usa()

%%
warning('off','MATLAB:table:ModifiedAndSavedVarnames')
t=readtable('data/cpi_yoy_usa.csv','Format','%{yyyy-MM-dd}D%f');
%t=readtable('data/cpi_yoy_usa.csv');

t=sortrows(t);

%%
sind=1;
dates=t.Date(sind:end);
cpi=t.LastPrice(sind:end);