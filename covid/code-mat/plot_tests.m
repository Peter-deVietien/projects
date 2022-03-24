cca
reset(0)
set(0,'defaultlinelinewidth',4)

%%
load_covid_data

%%
percent_pos=increase_positive./increase_tests*100;
ma_days=7;
a_ind=find(dates>datetime(2020,04,01),1,'first');

%%
bar(dates,increase_tests/1000)
hold on
plot(dates,moving_average(dates,increase_tests/1000,ma_days),...
    'color',[0.9290, 0.6940, 0.1250])
hold off

%%
selb=day(dates,'dayofweek')~=1;
sunday_tests=increase_tests/1000;
sunday_tests(selb)=0;

hold on
bar(dates,sunday_tests)
hold off


yyaxis right

perc_pos=moving_average(dates,percent_pos(a_ind:end),ma_days);
plt_colors=[0.8500, 0.3250, 0.0980];
hold on
ph=plot(dates(a_ind:end),perc_pos,'color','cyan','linewidth',7)
hold off
%%

yh=ylabel('Percent Positive','fontsize',30);

yyaxis left
ylabel('Tests Performed (thousands)','fontsize',30)
grid on
text(datetime(2020,04,25),1040,'@peterdevietien','fontsize',20)

yyaxis right


ylim([0 25])
xlim([datetime(2020,03,15) datetime('now')+5])

ax=gca;
ax.FontSize=20;
ax.YAxis(2).Color = 'k';

fig=gcf;
fig.Position=[200 159 975 541];

title_str=sprintf('%d Day Rolling Average of COVID Testing\nData until %s, from covidtracking.com',ma_days,datestr(dates(end),'mmmm dd'));
title(title_str,'FontSize',25)

legend(ph,'Percent Positive Tests')


print('plot_tests','-dpng')