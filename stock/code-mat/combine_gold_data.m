cca

plot_data=true;

k=readtable('../data/gold_price_1833_2016_annually.csv');
kyears=datetime(k{1:2:end,1},7,1);
kprice=k{2:2:end,1};

kyears=[[datetime(1833,7,1):calyears(1):datetime(1849,7,1)]';kyears];
kprice=[ones(1850-1833,1)*kprice(1);kprice];

ksdate=[kyears(1):calmonths(1):kyears(end)]';
[~,ksprice]=dspline(kyears,kprice,ksdate);



if plot_data

plot(kyears,kprice);

hold on
plot(ksdate,ksprice)
hold off

end
%%
j=readtable('../data/gold_price_1950_2018_monthly.csv');

jdate=j.date;
jprice=j.price;

if plot_data
hold on
plot(jdate,jprice)
hold off


fig=gcf;
fig.Position=[176 207 1231 659];

xlim([datetime(1950,1,1) datetime(2022,1,1)])

end



%%

kind=find(ksdate>jdate(1),1,'first');

combined_dates=[ksdate(1:kind);jdate];
combined_prices=[ksprice(1:kind);jprice];

t=table();
t.dates=combined_dates;
t.prices=combined_prices;

if plot_data
    plot(combined_dates,combined_prices)
    
end

write_data=false;
if write_data
    writetable(t,'../data/gold_price_1833_2018_monthly.csv')
end