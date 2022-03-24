% https://www.nicd.ac.za/diseases-a-z-index/disease-index-covid-19/surveillance-reports/daily-hospital-surveillance-datcov-report/
clear
close all

%
load_nicd_SA

%
yyaxis left
h(1)=bar(dates,hosp(:,4),'b');
ylabel('Patients in ICU','color','b')


yyaxis right
hold on
h(2)=bar(dates,hosp(:,5));
hold off
ylabel('Patients on Ventilator')

h(1).FaceAlpha=0.8;
h(2).FaceAlpha=0.8;

ylim([0 400])

%set(gca, 'Children', flipud(get(gca, 'Children')) )

%
ax=gca;
ax.FontSize=18;
ax.XTick=[dates(1):2:dates(end)];
ax.XTickLabel=datestr(ax.XTick,'mmm dd');
%datetick('x','mmm dd')


xlim([datetime(2021,11,25)-0.5 dates(end)+0.5])

fig=gcf;
fig.Position=[83 185 571 506];

grid on

title('South African COVID ICU and Ventilators')

%

text(datetime(2021,11,27),240,'www.nicd.ac.za','fontsize',16)
text(datetime(2021,11,27),220,'@peterdevietien','fontsize',16)

%
print('~/projects/covid/post/omicron/SA_ICU_Vents','-dpng','-r250')