cca

%%
series_key='TOTAL.TETCBUS.M ';

%%
[dinit,metadata1]=load_eia_series(series_key);
d=process_monthly_data(dinit);

dates=d.dates;
tbtu_per_month=d.y;


%%
leftycolor=[0 0.4470 0.7410];
rightycolor=[0.8500 0.3250 0.0980];
%%

btu_per_boe=5.799e+6;

mboe_per_month=tbtu_per_month/btu_per_boe*1e6;
mboe_per_day=mboe_per_month/30;


j_per_boe = 6.118e9;
tj_per_boe = j_per_boe/1e12;
tj_per_day=tj_per_boe*(mboe_per_day*1e6);
terawatts=tj_per_day/(24*60*60);

%%
plot(dates,mboe_per_day,'linewidth',6,'color',leftycolor)

grid on

ytickformat('%,.0d')
ax=gca;
ax.YAxis(1).Exponent=0;
ax.FontSize=19;

fig=gcf;
fig.Position=[203 287 1173 579];

ylabel(sprintf('Million BOE Per Day'))

y_lim=[35 60];
ylim(y_lim)
ax=gca;
yticks=ax.YTick;
yyaxis right

%% Find TW equivalent

yrat=y_lim./mboe_per_day(1);

ylim2=yrat*terawatts(1);
ylim(ylim2);


ax=gca;
ax.YAxis(2).Color='k';

nyticks=numel(yticks)

ax.YTick=round(linspace(ylim2(1),ylim2(2),nyticks),1);

ylabel('Terawatts')


%%



xlim([datetime(2018,6,1) datetime(2021,6,1)])

title(sprintf('USA Energy Consumption \nIn Both Barrels of Oil Equivalent and Terawatts'))

%%
text(datetime(2007,1,1),-5,'@peterdevietien  Data: EIA','fontsize',16)

%%
print('~/projects/eia/post/primary_consumption_usa','-dpng')
