cca

%%
series_key1='INTL.44-2-WORL-TJ.A';
series_key2='INTL.5-2-WORL-TBPD.A';

%%
[dinit1,metadata1]=load_eia_series(series_key1);
d1=process_annual_data(dinit1);

[dinit2,metadata2]=load_eia_series(series_key2);
d2=process_annual_data(dinit2);

%%
leftycolor=[0 0.4470 0.7410];
rightycolor=[0.8500 0.3250 0.0980];
%%

j_per_boe = 6.118e9;
tj_per_boe = j_per_boe/1e12;

tj_vs_t=d1.y;
boe_vs_t=tj_vs_t/tj_per_boe;
mboe_vs_t=boe_vs_t/1e6;
mboepd_vs_t=mboe_vs_t/365;

%%
plot(d1.dates,mboepd_vs_t,'linewidth',6,'color',leftycolor)

grid on

ytickformat('%,.0d')
ax=gca;
ax.YAxis(1).Exponent=0;
ax.FontSize=19;

fig=gcf;
fig.Position=[203 305 847 561];

ylabel(sprintf('Million BOE Per Day'))

ylim([120 320])

yyaxis right

ax=gca;
ax.YAxis(1).Color=leftycolor;
ax.YAxis(2).Color=rightycolor;

d2.dates(end)=[];
d2.y(end)=[];
mbpd_vs_t=d2.y/1000;
percent=mbpd_vs_t(end-39:end)./mboepd_vs_t(end-39:end)*100;

plot(d2.dates(end-39:end),percent,'linewidth',6)

ylabel('Oil Percentage of Total Energy')

ylim([0 50])

title(sprintf('Global Energy Consumption \nBarrels of Oil Equivalent'))

%%
text(datetime(2007,1,1),-5,'@peterdevietien  Data: EIA','fontsize',16)

%%
print('~/projects/eia/post/energy_consumption_boe_global','-dpng')
