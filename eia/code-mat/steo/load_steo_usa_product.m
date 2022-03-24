function [dates,usa_prod] = load_steo_usa_product(filename)

filepath=sprintf('~/projects/eia/data/steo/%s',filename);

t=readtable(filepath,'Sheet','3atab','Range','C7:BV7');

tt=rows2vars(t);
usa_prod=tt.Var1;

nanind=isnan(usa_prod);
usa_prod(nanind)=[];

%%
dates=datetime(2017,1,1):calmonths(1):datetime(2022,12,1);
if strcmp(filename,'jan22_base.xlsx') | strcmp(filename,'feb22_base.xlsx')
    dates=dates+calmonths(12);
end

