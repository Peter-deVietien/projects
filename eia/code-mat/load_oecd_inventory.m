cca

series_key1='STEO.PASC_OECD_T3.M';
series_key2='STEO.COSQPUS.M';
series_key3='INTL.5-5-OECD-MBBL.M';

[dinit1,metadata1]=load_eia_series(series_key1);
d1=process_monthly_data(dinit1);

[dinit2,metadata2]=load_eia_series(series_key2);
d2=process_monthly_data(dinit2);

[dinit3,metadata3]=load_eia_series(series_key3);
d3=process_monthly_data(dinit3);

%%

sdate=max([d1.dates(1),d2.dates(1),d3.dates(1)]);

sel=d1.dates<sdate;
d1.dates(sel)=[];
d1.y(sel)=[];

sel=d2.dates<sdate;
d2.dates(sel)=[];
d2.y(sel)=[];

sel=d3.dates<sdate;
d3.dates(sel)=[];
d3.y(sel)=[];

scale=2;
fig=figure;
fig.Position=[75.8000 342 1200/scale 675/scale];

plot(d1.dates,d1.y,'b','linewidth',1)

hold on
plot(d2.dates,d1.y+d2.y,'r','linewidth',1)
plot(d3.dates,d3.y,'m','linewidth',1)

hold off

%%
xlim([datetime(2000,1,1) datetime()+calmonths(6)])

grid on

ax=gca;
ax.XGrid='off';
ax.FontSize=14;

lgn=legend('STEO Commercial Crude Oil and Other Liquids Inventory','STEO Commercial Crude Oil and Other Liquids Inventory + U.S. SPR','Petroleum and other liquids stocks, OECD: Ends Feb 2022');
lgn.Position=[0.1791 0.1441 0.7150 0.1484];

ylim([1500 5000])

ylabel('Million Barrels')
title('Attempting to get total OECD inventories')

print('~/projects/eia/post/total_oecd_inventory','-dpng')