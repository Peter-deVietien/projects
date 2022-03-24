function [dates,production] = load_weekly_domestic(filename)

filepath=sprintf('~/projects/eia/data/%s',filename);

t=readtable(filepath,'Sheet','Data 3','Range','A3:P2060');

dates=t.Date;
domestic_prod=t.x4_WeekAvgU_S_FieldProductionOfCrudeOil_ThousandBarrelsPerDay_;

sdates=days(dates-dates(1));
domestic_prod=spline(sdates,domestic_prod,sdates);

production=domestic_prod;
