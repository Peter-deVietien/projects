cca

%%
series_key1='INTL.2-2-NOR-BKWH.A';
series_key2='INTL.5-2-NOR-TBPD.A';


%%
[dinit1,metadata1]=load_eia_series(series_key1);
d1=process_annual_data(dinit1);

[dinit2,metadata2]=load_eia_series(series_key2);
d2=process_annual_data(dinit2);

%%
leftycolor=[0 0.4470 0.7410];
rightycolor=[0.8500 0.3250 0.0980];
%%

%%
plot(d1.dates,d1.y,'linewidth',4,'color',leftycolor)

grid on



ylabel(sprintf('Electricity Consumption [GWh]'))


yyaxis right

plot(d2.dates,d2.y,'linewidth',4,'color',rightycolor)

ylabel('Petroleum and Other Liquids Consumed [kbpd]')

%%

ax=gca;
ax.FontSize=19;

fig=gcf;
fig.Position=[203 305 847 561];

ax.YAxis(1).Color=leftycolor;
ax.YAxis(2).Color=rightycolor;

title(sprintf('Energy Consumption Norway'),'fontsize',25)

%%
text(datetime(2008,1,1),153,'@peterdevietien  Data: EIA','fontsize',16)



%%
print('~/projects/eia/post/energy_consumption_norway','-dpng')
