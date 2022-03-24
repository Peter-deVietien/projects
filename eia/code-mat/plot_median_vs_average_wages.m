cca

%%
[mdates,mwages]=median_wages_vs_t();
[adates,awages]=average_wages_vs_t();
[hdates,hours]=avg_weekly_hours_all_employees();

awages=awages.*hours;

%%
plot(mdates,mwages,'-b','linewidth',3);
hold on
plot(adates,awages,'-g','linewidth',3);
hold off

%%

fig=gcf;
fig.Position=[476 475 852 405];

ylabel('Weekly Income [2022 USD]')

lgn=legend('Average Weekly Wages','Median Weekly Wages','fontsize',20);
lgn.Position=[0.1305 0.7717 0.3192 0.1346];

ax=gca;
ax.FontSize=20;
ax.YGrid='on';

text(0.5,0.055,sprintf('Average Weekly Wage = Average Weekly Hours of All Employees, Total Private,\n Average Hourly Earnings of All Employees, Total Private'),'units','normalized','fontsize',14,'horizontalalignment','center');
text(0.8,-0.11,'Twitter: @peterdevietien   Data: St. Louis Fed','units','normalized','fontsize',14,'horizontalalignment','center');

%%
title('U.S. Weekly Personal Income: Median and Average','fontsize',25)

%%
lgn=legend('Median Salaries Quarterly','Average Salaries Monthly');

%%
print('~/projects/eia/post/median_vs_average_wages','-dpng')