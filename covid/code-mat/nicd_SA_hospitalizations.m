% https://www.nicd.ac.za/diseases-a-z-index/disease-index-covid-19/surveillance-reports/daily-hospital-surveillance-datcov-report/
clear
close all

%
load_nicd_SA

%
yyaxis left
h(1)=bar(dates,hosp(:,3),'b');
ylabel('Total COVID Hospitalized')


yyaxis right
hold on
h(2)=bar(dates,hosp(:,4));
hold off
ylabel('COVID ICU')

h(1).FaceAlpha=0.8;
h(2).FaceAlpha=0.8;

ylim([0 900])

set(gca, 'Children', flipud(get(gca, 'Children')) )

%
ax=gca;
ax.FontSize=18;
dispdates=[dates(end-60):2:dates(end)];
ax.XTick=dispdates;
ax.XTickLabel=datestr(dispdates,'mmm dd');
%datetick('x','mmm dd')


xlim([datetime(2021,11,25)-0.5 dates(end)+0.5])

fig=gcf;
fig.Position=[83 185 571 506];

grid on

title('South African COVID Hospitalizations')

%

text(datetime(2021,11,27),620,'www.nicd.ac.za','fontsize',16)
text(datetime(2021,11,27),580,'@peterdevietien','fontsize',16)

%
print('~/projects/covid/post/omicron/nicd_SA_hospitalizations','-dpng','-r250')