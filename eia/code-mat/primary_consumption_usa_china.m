cca

%%
series_key1='INTL.44-2-USA-TJ.A';
series_key2='INTL.44-2-WP15-TJ.A';


%%
[dinit1,metadata1]=load_eia_series(series_key1);
d1=process_annual_data(dinit1);

[dinit2,metadata2]=load_eia_series(series_key2);
d2=process_annual_data(dinit2);


j_per_boe = 6.118e9;
tj_per_boe = j_per_boe/1e12;

tj_vs_t1=d1.y;
tj_vs_t2=d2.y;

boe_vs_t1=tj_vs_t1/tj_per_boe;
mboe_vs_t1=boe_vs_t1/1e6;
mboepd_vs_t1=mboe_vs_t1/365;

boe_vs_t2=tj_vs_t2/tj_per_boe;
mboe_vs_t2=boe_vs_t2/1e6;
mboepd_vs_t2=mboe_vs_t2/365;


%%
leftycolor=[0 0.4470 0.7410];
rightycolor=[0.8500 0.3250 0.0980];
%%

%%
plot(d1.dates,mboepd_vs_t1,'linewidth',6,'color',leftycolor)
hold on
plot(d2.dates,mboepd_vs_t2,'linewidth',6,'color',rightycolor)
hold off



grid on

%%
fig=gcf;
fig.Position=[203 305 847 561];


ax=gca;
ax.FontSize=23;
yticks=ax.YTick;
y_lim=[0 80];

ylbl=ylabel(sprintf('Energy Consumption [mboe per day]'),'fontsize',21);
ylbl.Position(1)=-900;

yyaxis right
ax=gca;
ax.YAxis(2).Color='k';
ax.YTick=yticks;
ylim(y_lim)


title(sprintf('Total Energy Consumption: U.S. and China'),'fontsize',25)

%%
lgn=legend('U.S.','China','fontsize',22);
lgn.Position=[0.2149 0.7175 0.1222 0.1096];

%%
text(0.6,-0.1,'Twitter @peterdevietien  Data: EIA','fontsize',17,'units','normalized')

%%
print('~/projects/eia/post/primary_consumption_china_usa','-dpng')
