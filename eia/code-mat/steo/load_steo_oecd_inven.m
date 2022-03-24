function [dates,oecd_inv] = load_steo_comm_inven(filename)

filepath=sprintf('~/projects/eia/data/steo/%s',filename);

t=readtable(filepath,'Sheet','3atab','Range','C46:CV46');

tt=rows2vars(t);
oecd_inv=tt.Var1;

nanind=isnan(oecd_inv);
oecd_inv(nanind)=[];

%%

load_steo_shift_dates

end

