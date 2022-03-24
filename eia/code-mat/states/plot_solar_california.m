cca

series_key1='ELEC.GEN.TSN-CA-99.M';

addpath('../')
[dinit1,metadata1]=load_eia_series(series_key1);
d1=process_monthly_data(dinit1);

%%
leftycolor=[0 0.4470 0.7410];
rightycolor=[0.9290 0.6940 0.1250];
%%

plot(d1.dates,d1.y,'linewidth',3,'color',leftycolor)

grid on
ytickformat('%,.0d')
ax=gca;
ax.FontSize=18;
ax.YAxis(1).Exponent=0;

ylabel('Solar Generation [GWh]')

fig=gcf;
fig.Position=[476 409 773 457];

tstr=sprintf('All Solar Power Generation in California, Monthly');
title(tstr,'fontsize',25)

%%
text(0.5,-0.1,'Twitter: @peterdevietien  Data: EIA','fontsize',18,'units','normalized')

print('~/projects/eia/post/solar_california','-dpng')