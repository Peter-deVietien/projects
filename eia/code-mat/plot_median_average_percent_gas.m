cca

series1='PET.EMM_EPMR_PTE_NUS_DPG.W';

%%
[dinit1,metadata]=load_eia_series(series1);
d1=process_weekly_data(dinit1);

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
p=plot(d1.dates(1:eind),mpercent,'-b','linewidth',3);
p.Color(4)=0.7;
hold on
p=plot(avg_dates,apercent,'-m','linewidth',3);
p.Color(4)=0.3;
hold off

%%

fig=gcf;
fig.Position=[476 434 932 446];

ylabel('Percent of Income')

lgn=legend('Percent of Median Daily Wages','Percent of Average Daily Wages','fontsize',20);
lgn.Position=[0.1305 0.6952 0.4108 0.1346];

ax=gca;
ax.FontSize=20;
ax.YGrid='on';

text(0.5,0.055,sprintf('Average Daily Wage = Average Weekly Hours of All Employees, Total Private,\n Average Hourly Earnings of All Employees, Total Private / 5'),'units','normalized','fontsize',14,'horizontalalignment','center');
text(0.8,-0.11,'Twitter: @peterdevietien   Data: St. Louis Fed','units','normalized','fontsize',14,'horizontalalignment','center');

ylim([0 30])
xlim([d1.dates(1) avg_dates(end)+calmonths(3)])

%%
title(sprintf('U.S. Percent of Daily Median and Average\nIncome for 10 Gallons of Gasoline'),'fontsize',25)


%%
print('~/projects/eia/post/median_vs_average_percent_gas','-dpng')