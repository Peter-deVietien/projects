function [dates,production] = load_weekly_production(filename)

filepath=sprintf('~/projects/eia/data/%s',filename);

t=readtable(filepath,'Sheet','Data 3','Range','A3:P2100');


dates=t.Date;
domestic_prod=t.x4_WeekAvgU_S_FieldProductionOfCrudeOil_ThousandBarrelsPerDay_;
other_prod=t.x4_WeekAvgU_S_RefinerAndBlenderNetProductionOfPetroleumProducts;

sel=find(isnan(domestic_prod(end-200:end)),1,'first');
domestic_prod(end-(200-sel)-1:end)=[];

sel=find(isnan(other_prod(end-200:end)),1,'first');
other_prod(end-(200-sel)-1:end)=[];

dates(end-(200-sel)-1:end)=[];

production=domestic_prod+other_prod;

%%
sel=isnan(production);
production(sel)=[];
dates(sel)=[];

