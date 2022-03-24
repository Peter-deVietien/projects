cca

load_covid_data

death_factor=1;
increase_deaths=increase_deaths*death_factor;

bar(dates,current_icu,'facecolor',[0.8500 0.3250 0.0980]);

ma_days=7;
hold on
plot(dates,moving_average(dates,current_icu,ma_days),'linewidth',6,'color','b')
hold off

ylabel('Patients in ICU')

yyaxis right
bar(dates,increase_deaths,'facecolor',[0 0 0]);


%%
selb=day(dates,'dayofweek')~=1;
sunday_deaths=increase_deaths;
sunday_deaths(selb)=0;

hold on
bar(dates,sunday_deaths,'facecolor',[0.9290 0.6940 0.1250])
plot(dates,moving_average(dates,increase_deaths,ma_days),'linewidth',6,...
    'color','cyan','linestyle','-')
hold off

%annotation('textarrow',[dates(end) dates(end)],[increase_deaths(end)+50 increase_deaths(end)+5],'String','test')

fig=gcf;
fig.Position=[17 103 1336 625];

grid on

ax=gca;
ax.FontSize=25;
ax.YAxis(2).Color = 'k';
ax.YAxis(1).Color = [0.8500 0.3250 0.0980];


ylabel('Daily Deaths')

xlim([datetime(2020,03,01) dates(end)+3])

title_str=sprintf('%d Day Rolling Average of COVID ICU and Deaths\nData includes %s, from covidtracking.com',ma_days,datestr(dates(end),'mmmm dd'));
title(title_str,'FontSize',25)