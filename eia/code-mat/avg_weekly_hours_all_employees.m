function [hdates,hours]=avg_weekly_hours_all_employees()

t=readtable('~/projects/eia/data/avg_weekly_hours_all_employees.xls');

hours=t.AverageWeeklyHoursOfAllEmployees_TotalPrivate_Hours_Monthly_Sea;
dates=t.AWHAETP;

sdates=dates(1):calmonths(1):dates(end);

shours=dspline(dates,hours,sdates);

%%
hdates=sdates;
hours=shours;
