function [dates,interest]=load_federal_debt_interest_rate()

warning('off','MATLAB:table:ModifiedAndSavedVarnames')
t=readtable('../data/federal_debt_interest_rate.csv');

sel=strcmp(t.SecurityDescription,'Total Interest-bearing Debt');

dates=datetime(t.RecordDate(sel));
interest=t.AverageInterestRateAmount(sel);

%%
[dates,si]=sort(dates);
interest=interest(si);