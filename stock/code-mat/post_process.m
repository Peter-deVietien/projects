cca

load post/pp.mat

nx=size(pp);

%% Make a monthly table instead of daily
ppm=pp;
ppm(:,:)=[];


cmonths=datetime(2020,1,1):calmonths(1):datetime(2020,12,31);
dates=datetime(2020,1,1):days(1):datetime(2020,12,31);

%Loop over every day.  Find maximum within month, and make that the month
%value
for m=1:numel(cmonths)
    
    minds=month(pp{:,1})==m;
    for n=2:nx(2)
        ppm(m,n)={max(pp{minds,n})};
    end
end

for i=1:12
ppm.dates(i)=cmonths(i)
end

writetable(ppm,'PdV_Etrade_monthly.csv')