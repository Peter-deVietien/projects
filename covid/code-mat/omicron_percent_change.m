% https://www.nicd.ac.za/diseases-a-z-index/disease-index-covid-19/surveillance-reports/daily-hospital-surveillance-datcov-report/
cca

start_date=datetime(2021,11,25);
end_date=datetime;
country='South Africa';

%%
load_nicd_SA

%%

istart=find(dates==start_date);


hold on
hold off

%%
load_owid_data

sel=ismember(t.location,country);
odates=t.date(sel);

cma=7;
dma=7;

% Remove nans
seln=isnan(t.new_cases);
t.new_cases(seln)=0;

ocases=moving_average(odates,t.new_cases(sel),cma);
odeaths=moving_average(odates,t.new_deaths(sel),dma);

istarto=find(odates==start_date);


plot(odates,ocases/ocases(istarto)*100,'linewidth',5,'color','blue')

hold on
plot(dates,hosp(:,3)/hosp(istart,3)*100,'linewidth',5,'color','green')
plot(dates,hosp(:,4)/hosp(istart,4)*100,'linewidth',5,'color','m')
plot(odates,odeaths/odeaths(istarto)*100,'linewidth',5,'color','red')
hold off


title_str=sprintf('%s COVID Percent Changes',country);
title(title_str)

%
locx=datetime(2021,11,25);
locy=2850;
dloc=120;

text(locx,locy,'www.nicd.ac.za','fontsize',16)
text(locx,locy-dloc,'@peterdevietien','fontsize',16)

lgn=legend('Cases','Hospitalized','ICU','Deaths','location','northwest');
lgn.Position=[0.5623 0.3097 0.2260 0.1661];

%
ax=gca;
ax.FontSize=22;
ax.XTick=odates(end-50:end)+1;
ax.XTickLabel=datestr(ax.XTick,'mmm dd');


xlim([start_date-0.5 end_date+0.5])

fig=gcf;
fig.Position=[83 92 803 697];

    ytickformat('%,.0d%%')

    ax=gca;
    ax.YAxis(1).Exponent=0;

grid on

%
printstr=sprintf('~/projects/covid/post/omicron/omicron-percent-change-%s-%s',country,datestr(start_date));
print(printstr,'-dpng','-r250')