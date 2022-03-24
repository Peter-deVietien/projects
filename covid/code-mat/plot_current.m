
cca
figure

set(0,'defaultlinelinewidth',5)

load_covid_data

percent_icu=current_icu./current_hospitalized*100;
percent_positive=percent_positive*100;
a_ind=find(dates>datetime(2020,04,01),1,'first');

avg_days=7;
lgs=[];
hold on
h(1)=plot(dates,moving_average(dates,current_hospitalized,avg_days));
lgs=[lgs {'Current Hospitalizations'}];
h(2)=plot(dates,moving_average(dates,current_icu,avg_days));
lgs=[lgs {'Current ICU Admissions'}];
h(3)=plot(dates,moving_average(dates,increase_deaths*7,avg_days));
lgs=[lgs {'Daily Deaths*7'}];
yyaxis right
h(4)=plot(dates(a_ind:end),moving_average(dates(a_ind:end),percent_icu(a_ind:end),avg_days),'c-');
lgs=[lgs {'Percent in ICU'}];
h(5)=plot(dates(a_ind:end),moving_average(dates(a_ind:end),percent_positive(a_ind:end),avg_days),'m-');
lgs=[lgs {'Percent Positive Tests'}];
yyaxis left
h(6)=plot(dates,moving_average(dates,current_ventilator,avg_days));
lgs=[lgs {'People on Ventillators'}];
hold off

%%

fig=gcf;
fig.Position=[-95 158 1264 589];

ylim([0 6]*1e4)
yyaxis right
ylim([0 30])
yyaxis left
grid on

title_str=sprintf('%d Day Rolling Average of COVID Metrics\nData until %s, from covidtracking.com',avg_days,datestr(dates(end),'mmmm dd'));
title(title_str,'FontSize',25)

lgh=legend(h,lgs,'location','west');
lgh.AutoUpdate='off';
%0.526942684926336,0.695495694413778,0.262488646684831,0.175425038639876
ax=gca;
ax.FontSize=20;

lgh.FontSize=23;
lgh.Position(1)=0.13;
lgh.Position(2)=0.56;

yyaxis right
ylabel('Percentages','fontsize',30)
yyaxis left
ylabel('Current Totals','fontsize',30)

%%
print('current_values','-dpng')