cca

load_covid_data

%%
increase_positive=increase_positive/1000;
current_hospitalized=current_hospitalized/1000;
current_icu=current_icu/1000;
increase_deaths=increase_deaths/1000;

%%
ma_days=7;
hold on
bar(dates,increase_positive,'facecolor',[0 1 0]);
bar(dates,current_hospitalized,'facecolor',[0.8500 0.3250 0.0980]);
bar(dates,current_icu,'facecolor',[0 0 1]);
bar(dates,moving_average(dates,increase_deaths,ma_days),'facecolor','cyan')
hold off

ylabel('[Thousands]')
text(datetime(2020,03,20),1050,'@peterdevietien','fontsize',20)

%%
%annotation('textarrow',[dates(end) dates(end)],[increase_deaths(end)+50 increase_deaths(end)+5],'String','test')

fig=gcf;
fig.Position=[17 103 1336 625];

grid on

ax=gca;
ax.FontSize=25;

xlim([datetime(2020,03,01) dates(end)+3])

title_str=sprintf('%d Day Rolling Average of COVID Hospitalizations and Deaths\nData includes %s, from covidtracking.com',ma_days,datestr(dates(end),'mmmm dd'));
title(title_str,'FontSize',25)

lgn=legend('Positive Tests','Hospitalized','ICU','Deaths');
lgn.Position=[0.3563 0.6180 0.1467 0.2256];

print('bar_postests_hosp_icu','-dpng')