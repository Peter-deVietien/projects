% https://www.nicd.ac.za/diseases-a-z-index/disease-index-covid-19/surveillance-reports/daily-hospital-surveillance-datcov-report/
cca

start_date=datetime(2021,4,15);
start_date2=datetime(2021,11,20);
end_date=datetime(2021,7,15);
dind=180;
country='South Africa';

%%
load_owid_data

sel=ismember(t.location,country);
dates=t.date(sel);

cma=7;
hma=7;
dma=7;

cases=t.new_cases(sel);
deaths=t.new_deaths(sel);

% Remove nans
seln=isnan(cases);
cases(seln)=0;
seln=find(isnan(deaths));
        deaths(seln(end-1))=mean(deaths(seln(end-1)-1),deaths(seln(end-1)+1));
        deaths(seln(end))=deaths(seln(end)-1);


casesma=moving_average(dates,cases,cma);
%hosps=moving_average(dates,t.weekly_hosp_admissions(sel),hma);
deathsma=moving_average(dates,deaths,dma);

istart=find(dates==start_date);
istart2=find(dates==start_date2);

plot([1:numel(dates)]-istart,casesma/casesma(istart)*100,'linewidth',5,'color','blue','linestyle','--')

hold on
%plot(dates,hosps/hosps(istart)*100,'linewidth',5,'color','red')
plot([1:numel(dates)]-istart,deathsma/deathsma(istart)*100,'linewidth',5,'color','red','linestyle','--')

plot([1:numel(dates)]-istart2,casesma/casesma(istart2)*100,'linewidth',5,'color','blue','linestyle','-')
plot([1:numel(dates)]-istart2,deathsma/deathsma(istart2)*100,'linewidth',5,'color','red','linestyle','-')
hold off


title_str=sprintf('%s Omicron vs Delta\nIncludes %s',country,datestr(dates(end),'mmm dd'));
title(title_str)

%
locx=86;
locy=300;
dloc=160;

text(locx,locy,'@OurWorldInData','fontsize',16)
text(locx,locy-dloc,'@peterdevietien','fontsize',16)

[lgn,icons]=legend('Cases - Delta','Deaths - Delta','Cases - Omicron','Deaths - Omicron','location','northwest');
lgn.Position=[0.5724 0.5366 0.2769 0.1688];

icons(1).FontSize=18;
icons(2).FontSize=18;
icons(3).FontSize=18;
icons(4).FontSize=18;


%
ax=gca;
ax.FontSize=22;
% ax.XTick=dates(end-50:end)+1;
% ax.XTickLabel=datestr(ax.XTick,'mmm dd');


xlim([1 dind])

fig=gcf;
fig.Position=[83 92 803 697];

    ytickformat('%,.0d%%')

    ax=gca;
    ax.YAxis(1).Exponent=0;

grid on

%
printstr=sprintf('~/projects/covid/post/omicron/omicron-delta-percent-change-%s-%s',country,datestr(start_date));
print(printstr,'-dpng','-r250')