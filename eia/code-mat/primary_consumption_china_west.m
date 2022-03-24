cca

%%
series_key1='INTL.44-2-NOAM-TJ.A';
series_key2='INTL.44-2-OEEU-TJ.A';
series_key3='INTL.44-2-CSAM-TJ.A';
series_key4='INTL.44-2-WP15-TJ.A';

%%
[dinit1,metadata1]=load_eia_series(series_key1);
d1=process_annual_data(dinit1);

[dinit2,metadata2]=load_eia_series(series_key2);
d2=process_annual_data(dinit2);

[dinit3,metadata3]=load_eia_series(series_key3);
d3=process_annual_data(dinit3);

[dinit4,metadata4]=load_eia_series(series_key4);
d4=process_annual_data(dinit4);

%%
color1=[0 0.4470 0.7410];
color2=[0.4660 0.6740 0.1880];

%%

j_per_boe = 6.118e9;
tj_per_boe = j_per_boe/1e12;

tj_vs_t1=d1.y;
tj_vs_t2=d2.y;
tj_vs_t3=d3.y;
tj_vs_t4=d4.y;

boe_vs_t1=tj_vs_t1/tj_per_boe;
mboe_vs_t1=boe_vs_t1/1e6;
mboepd_vs_t1=mboe_vs_t1/365;


boe_vs_t2=tj_vs_t2/tj_per_boe;
mboe_vs_t2=boe_vs_t2/1e6;
mboepd_vs_t2=mboe_vs_t2/365;

boe_vs_t3=tj_vs_t3/tj_per_boe;
mboe_vs_t3=boe_vs_t3/1e6;
mboepd_vs_t3=mboe_vs_t3/365;


mboepd_vs_t_west=mboepd_vs_t1+mboepd_vs_t2+mboepd_vs_t3;


boe_vs_t4=tj_vs_t4/tj_per_boe;
mboe_vs_t4=boe_vs_t4/1e6;
mboepd_vs_t4=mboe_vs_t4/365;

%%
plot(d1.dates,mboepd_vs_t_west,'linewidth',4,'color',color1)
hold on
plot(d2.dates,mboepd_vs_t4,'linewidth',4,'color','r')
hold off

grid on

ytickformat('%,.0d')
ax=gca;
ax.YAxis(1).Exponent=0;
ax.FontSize=19;

fig=gcf;
fig.Position=[203 305 847 561];

ylabel(sprintf('Million BOE Per Day'))
y_lim=[0 120];
yticks=[0:20:120];
ax=gca;
ylim(y_lim)
yticks=yticks;
ax.YTick=yticks;
yyaxis right

ax=gca;
ylim(y_lim)
yticks=yticks;
ax.YTick=yticks;
ax.YAxis(2).Color='k';

title(sprintf('Primary Energy Consumption \nChina vs The West'),'fontsize',28)

lgn=legend('North + South America + Europe','China','fontsize',25);
lgn.Position=[0.1363 0.3672 0.4799 0.1132];


%%
text(datetime(2002,3,1),-12,'Twitter: @peterdevietien    Data: EIA','fontsize',18)

%%
print('~/projects/eia/post/energy_consumption_west_vs_china','-dpng')
