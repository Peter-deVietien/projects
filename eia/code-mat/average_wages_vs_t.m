function [adates,awages]=average_wages_vs_t()

t=readtable('~/projects/eia/data/avg_hourly_all_employees.xls');

wages=t.AverageHourlyEarningsOfAllEmployees_TotalPrivate_DollarsPerHour;
dates=t.CES0500000003;

sdates=dates(1):calmonths(1):dates(end);

swages=dspline(dates,wages,sdates);

%% Normalize for 1982-1984 inflation
[adates,infl]=inflation_vs_t(sdates);
%infl=1;
awages=swages./infl;
