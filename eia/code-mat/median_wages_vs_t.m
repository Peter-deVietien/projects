function [mdates,mwages]=median_wages_vs_t()

t=readtable('~/projects/eia/data/median_real_wages.xls');

mwages=t.EmployedFullTime_MedianUsualWeeklyRealEarnings_WageAndSalaryWor;
mdates=t.LES1252881600Q;

sdates=mdates(1):calmonths(1):mdates(end);

swages=dspline(mdates,mwages,sdates);

%% Normalize for 1982-1984 inflation
[d,infl]=inflation_vs_t(datetime(1982,1,1):calmonths(1):datetime(1984,1,1));

mwages=swages./mean(infl);
mdates=sdates;
