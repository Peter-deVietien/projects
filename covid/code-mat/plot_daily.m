cca
figure

set(0,'defaultlinelinewidth',3)

load_data

avg_days=7;


plot(dates,moving_average(increase_deaths,avg_days))
hold on
plot(dates,moving_average(increase_hospitalized,avg_days))
plot(dates,moving_average(increase_positive,avg_days)*0.1)
plot(dates,moving_average(increase_tests,avg_days)*0.01)
hold off

%%
x_lim=xlim;
xlim([datetime(2020,03,01),x_lim(2)])

fig=gcf;
fig.Position=[71 279 759 504];

grid on

title_str=sprintf('%d Day Rolling Average of COVID Metrics\n Data until %s - from covidtracking.com',avg_days,datestr(dates(end),'mmmm dd'));
title(title_str)

lgh=legend('Died today','Hospitalized today','Tested positive today/10','Tested today/100','location','northwest');
lgh.FontSize=22;
lgh.AutoUpdate='off';

ax=gca;
ax.FontSize=20;
%%
print('daily_increases','-dpng')