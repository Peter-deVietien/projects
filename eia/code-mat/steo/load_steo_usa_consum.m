function [dates,oecd_inv] = load_steo_usa_consum(filename)

filepath=sprintf('~/projects/eia/data/steo/%s',filename);

t=readtable(filepath,'Sheet','3atab','Range','C24:BV24');

tt=rows2vars(t);
oecd_inv=tt.Var1;

nanind=isnan(oecd_inv);
oecd_inv(nanind)=[];

%%
last_year=23 + 2000;
fileyear=str2num(regexp(filename,'\d\d','match','once'))

if (last_year-fileyear)>1
    years_covered=fileyear+2+2000;
    %dyear=last_year-years_covered
    dates=datetime(years_covered-6,1,15):calmonths(1):datetime(years_covered-1,12,15);
end

