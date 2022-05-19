function [dates,usa_inv,spr_inv] = load_steo_usa_inven(filename)

filepath=sprintf('~/projects/eia/data/steo/%s',filename);

t=readtable(filepath,'Sheet','3atab','Range','C45:BV45');
t2=readtable(filepath,'Sheet','4atab','Range','C63:BV63');

if isnan(t2{1,1})
    t2=readtable(filepath,'Sheet','4atab','Range','C62:BV62');
end


tt=rows2vars(t);
usa_inv=tt.Var1;

nanind=isnan(usa_inv);
usa_inv(nanind)=[];


tt2=rows2vars(t2);
spr_inv=tt2.Var1;

nanind=isnan(spr_inv);
spr_inv(nanind)=[];


%%
last_year=23 + 2000;
fileyear=str2num(regexp(filename,'\d\d','match','once'))

if (last_year-fileyear)>1
    years_covered=fileyear+2+2000;
    %dyear=last_year-years_covered
    dates=datetime(years_covered-6,1,15):calmonths(1):datetime(years_covered-1,12,15);
end
