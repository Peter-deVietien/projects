function [dates,production] = load_weekly_production(filename)

filepath=sprintf('~/projects/eia/data/%s',filename);

t=readtable(filepath,'Sheet','Data 3','Range','A3:P2060');


dates=t.Date;
domestic_prod=t.x4_WeekAvgU_S_FieldProductionOfCrudeOil_ThousandBarrelsPerDay_;
other_prod=t.x4_WeekAvgU_S_RefinerAndBlenderNetProductionOfPetroleumProducts;

sel=isnan(domestic_prod);
domestic_prod(sel)=0;

sel=isnan(other_prod);
other_prod(sel)=0;

production=domestic_prod+other_prod;

