cca

load_covid_data

bar(dates,current_icu);

ma_days=7;
hold on
plot(dates,moving_average(dates,current_icu,ma_days),'linewidth',6)
hold off

%annotation('textarrow',[dates(end) dates(end)],[increase_deaths(end)+50 increase_deaths(end)+5],'String','test')

ax=gca;
ax.FontSize=20;

fig=gcf;
fig.Position=[17 103 1336 625];

grid on

ylabel('People in ICUs')

xlim([datetime(2020,03,01) dates(end)+3])

title_str=sprintf('%d Day Rolling Average of COVID ICU\nData until %s, from covidtracking.com',ma_days,datestr(dates(end),'mmmm dd'));
title(title_str,'FontSize',25)