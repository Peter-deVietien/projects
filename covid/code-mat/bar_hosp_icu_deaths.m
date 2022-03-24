cca

load_covid_data

%%
current_hospitalized=current_hospitalized/1000;
current_icu=current_icu/1000;
increase_deaths=increase_deaths/1000;

bar(dates,current_hospitalized,'facecolor',[0.8500 0.3250 0.0980]);

ma_days=7;
% hold on
% plot(dates,moving_average(dates,current_hospitalized,ma_days),'linewidth',6,'color','b')
% hold off

ylabel('Patients in Hospitals [Thousands]')
text(datetime(2020,05,20),51,'@peterdevietien','fontsize',20)
y_lim=ylim;
yyaxis right
bar(dates,current_icu,'facecolor',[0 0 0]);
ylim(y_lim)

%%
selb=day(dates,'dayofweek')~=1;
sunday_icu=current_icu;
sunday_icu(selb)=0;

hold on
bar(dates,sunday_icu,'facecolor',[0.9290 0.6940 0.1250])
bar(dates,moving_average(dates,increase_deaths,ma_days),'facecolor','cyan')
hold off

%annotation('textarrow',[dates(end) dates(end)],[increase_deaths(end)+50 increase_deaths(end)+5],'String','test')

fig=gcf;
fig.Position=[17 103 1336 625];

grid on

ax=gca;
ax.FontSize=25;
ax.YAxis(2).Color = 'k';
ax.YAxis(1).Color = [0.8500 0.3250 0.0980];


ylabel('Patients in ICU [thousands]')

xlim([datetime(2020,03,01) dates(end)+3])

title_str=sprintf('%d Day Rolling Average of COVID Hospitalizations and Deaths\nData includes %s, from covidtracking.com',ma_days,datestr(dates(end),'mmmm dd'));
title(title_str,'FontSize',25)

lgn=legend('Hospitalized','ICU','Sunday','Daily Deaths');
lgn.Position=[0.7231 0.6824 0.1257 0.1816];

print('bar_hosp_deaths','-dpng')