cca

series1='PET.EMM_EPMR_PTE_NUS_DPG.W';
series2='PET.MGFUPUS2.M';

%%
[dinit1,metadata]=load_eia_series(series1);
d1=process_weekly_data(dinit1);

[dinit2,metadata]=load_eia_series(series2);
d2=process_monthly_data(dinit2);

sel=d1.dates==d1.dates(20);
d1.dates(sel)=[];
d1.y(sel)=[];

%%
[mdates,mwages]=median_wages_vs_t();
[adates,awages]=average_wages_vs_t();
[hdates,hours]=avg_weekly_hours_all_employees();

awages=awages.*hours/5;

aind=find(d1.dates>adates(1),1,'first');
avg_dates=d1.dates(aind:end);

awages=dspline(adates,awages,avg_dates);

price=d1.y(aind:end)*10;

apercent=price./awages*100;

%%
mind=find(mdates>d1.dates(1),1,'first');
eind=find(d1.dates>mdates(end),1,'first');

mdates=mdates(mind:end);
mwages=dspline(mdates,mwages(mind:end),d1.dates(1:eind))/5;

mpercent=d1.y(1:eind)*10./mwages*100;

%%
msdates=d1.dates(1:eind);

aind=find(msdates>avg_dates(1),1,'first');

%%
fig=gcf;
fig.Position=[476 434 932 446];

p=plot(msdates(1:aind),mpercent(1:aind),'-b','linewidth',3);
p.Color(4)=0.3;
hold on
h(1)=plot(avg_dates,apercent,'-b','linewidth',3);
h(1).Color(4)=0.3;
hold off
ylabel('Percent of Wage')
ylim([2.5 24])

yyaxis right
%%
rightycolor=[0.8500 0.3250 0.0980];

h(2)=plot(d2.dates,d2.y,'linewidth',3,'color',rightycolor);
h(2).Color(4)=0.4;
ax=gca;
ax.YAxis(2).Color=rightycolor;

ylim([7000 10000])
ylabel('Gasoline Consumption [kbpd]')

ytickformat('%,.0d')
ax=gca;
ax.YAxis(1).Exponent=0;


lgn=legend(h,'Percent of Median Daily Wage','Gasoline Consumption','fontsize',20);
lgn.Position=[0.1293 0.7321 0.3525 0.1177];

ax=gca;
ax.FontSize=20;
ax.YGrid='on';

text(0.59,0.055,sprintf('Median Daily Wage = Average Weekly Hours of All Employees, Total Private,\n Median Hourly Earnings of All Employees, Total Private / 5'),'units','normalized','fontsize',14,'horizontalalignment','center');
text(0.75,-0.11,'Twitter: @peterdevietien   Data: EIA, St. Louis Fed','units','normalized','fontsize',14,'horizontalalignment','center');

xlim([d1.dates(1) avg_dates(end)+calmonths(3)])

%%
title(sprintf('U.S. Percent of Daily Median Income for\n 10 Gallons of Gasoline vs. Consumption'),'fontsize',25)


%%
print('~/projects/eia/post/median_percent_gas_consumption','-dpng')