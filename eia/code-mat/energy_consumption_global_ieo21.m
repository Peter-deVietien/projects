cca

%%
series_key1='INTL.44-2-WORL-QBTU.A';
series_key2='INTL.5-2-WORL-TBPD.A';
series_key3='IEO.2021.REFERENCE.CNSM_PE_WOR_QBTU.A';
%%
[dinit1,metadata1]=load_eia_series(series_key1);
d1=process_annual_data(dinit1);

[dinit2,metadata2]=load_eia_series(series_key2);
d2=process_annual_data(dinit2);

[dinit3,metadata3]=load_eia_series(series_key3);
d3=process_annual_data(dinit3);

%%
leftycolor=[0 0.4470 0.7410];
rightycolor=[0.8500 0.3250 0.0980];
%%
mboepd_1=quadbtu_to_mboe(d1.y)/365;
mboepd_ieo=quadbtu_to_mboe(d3.y)/365;

%%
plot(d1.dates,mboepd_1,'linewidth',6,'color',leftycolor)
hold on
plot(d3.dates,mboepd_ieo,'linewidth',2,'color',leftycolor,'linestyle','--')
hold off

grid on

ytickformat('%,.0d')
ax=gca;
ax.YAxis(1).Exponent=0;
ax.FontSize=19;

fig=gcf;
fig.Position=[203 305 847 561];

ylabel(sprintf('Million BOE Per Day'))

ylim([120 360])

yyaxis right

ax=gca;
ax.YAxis(1).Color=leftycolor;
ax.YAxis(2).Color=rightycolor;

d2.dates(end)=[];
d2.y(end)=[];
mbpd_vs_t=d2.y/1000;
percent=mbpd_vs_t(end-39:end)./mboepd_1(end-39:end)*100;

plot(d2.dates(end-39:end),percent,'linewidth',6,'color',rightycolor)

ylabel('Oil Percentage of Total Energy')

ylim([0 50])
xl=xlim;
xlim([xl(1) datetime(2031,1,1)])

title(sprintf('Global Energy Consumption \nBarrels of Oil Equivalent'))

lgn=legend('World Consumption','Word Consumption IEO 2021','Percent Oil');
lgn.Position=[0.5573 0.2335 0.3140 0.1212];

%%
text(0.6,-0.1,'Twitter: @peterdevietien  Data: EIA','fontsize',16,'units','normalized')

%%
print('~/projects/eia/post/energy_consumption_boe_global_ieo21','-dpng')
