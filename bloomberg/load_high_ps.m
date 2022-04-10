clear
close all

%%
warning('off','MATLAB:table:ModifiedAndSavedVarnames')
t=readtable('data/high_ps_worksheet.xlsx');

%%
ticker=regexp(t.Ticker,'[A-Z]{1,4}','match','once');
epsyoy=t.EPS_1YrGr_Q;
eps=t.EPST12M;
revyoy=t.Rev_1YrGr_Q;
rev=t.RevenueT12M;
debtasset=t.Debt_AssetsLF;
markcap=t.MarketCap;
evsales=t.EV_ThisYearEstSales;