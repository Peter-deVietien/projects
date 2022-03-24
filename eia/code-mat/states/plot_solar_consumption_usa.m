cca

series_key1='ELEC.GEN.TSN-US-99.M';
series_key2='TOTAL.TETCBUS.M';

addpath('../')
[dinit1,metadata1]=load_eia_series(series_key1);
d1=process_monthly_data(dinit1);

[dinit2,metadata2]=load_eia_series(series_key2);
d2=process_monthly_data(dinit2);

%%
rightycolor=[0 0.4470 0.7410];
leftycolor=[0.9290 0.6940 0.1250]*0.8;
%%
kwh=btu_to_kwh(d2.y*1e12);
twh=kwh/1e9;


%%

sdate=find(d2.dates>d1.dates(1),1,'first');

plot(d1.dates,d1.y/1000,'linewidth',5,'color',leftycolor)


grid on
ytickformat('%,.0d')
ax=gca;
ax.FontSize=18;
ax.YAxis(1).Exponent=0;
ylabel('U.S. Solar Generation [TWh]')

ylim([3.5 12])

yyaxis right

plot(d2.dates,twh,'linewidth',5,'color',rightycolor)

grid on
ytickformat('%,.0d')
ax=gca;
ax.FontSize=18;
ax.YAxis(1).Exponent=0;

ylabel('U.S. Energy Consumption [TWh]')

ax.YAxis(1).Color=leftycolor;
ax.YAxis(2).Color=rightycolor;

xlim([datetime(2017,5,1) datetime(2020,1,1)])

fig=gcf;
fig.Position=[476 359 872 507];


tstr=sprintf('U.S. Solar Generation\nU.S. Energy Consumption');
title(tstr,'fontsize',25)
ax.Position(2)=0.12;
ax.Position(3)=0.75;
ax.Position(4)=0.73;

text(0.58,0.08,sprintf('Solar\nGeneration'),'fontsize',22,'color',leftycolor*0.9,'units','normalized','horizontalalignment','center')
text(0.62,0.93,sprintf('Total\nConsumption'),'fontsize',22,'color',rightycolor,'units','normalized','horizontalalignment','center')

%%
text(0.5,-0.12,'Twitter: @peterdevietien  Data: EIA','fontsize',18,'units','normalized')

print('~/projects/eia/post/us_solar_consumption','-dpng')