% https://www.nicd.ac.za/diseases-a-z-index/disease-index-covid-19/surveillance-reports/daily-hospital-surveillance-datcov-report/
cca

%
load_nicd_SA

%
lag=5;

dates=dates(1+lag:end);
hospizalized=hosp(1:end-lag,3);
icud=hosp(1+lag:end,4);


perc_icu=icud./hospizalized*100;

h=plot(dates,perc_icu,'b','linewidth',5);
ylabel('Percent in ICU')

%
ax=gca;
ax.FontSize=18;
ax.XTick=dates;
%ax.XTickLabel=datestr(dates,'mmm dd');
%datetick('x','mmm dd')


xlim([datetime(2021,11,25)-0.5 dates(end)+0.5])

fig=gcf;
fig.Position=[83 163 664 528];

grid on

title(sprintf('South Africa Percent of Hospitalized in ICU\nLagging ICU admissions by 5 days'))

%

text(datetime(2021,11,26),6.5,'www.nicd.ac.za','fontsize',16)
text(datetime(2021,11,26),6.3,'@peterdevietien','fontsize',16)

%
print('~/projects/covid/post/omicron/nicd_SA_percent_icu','-dpng','-r250')