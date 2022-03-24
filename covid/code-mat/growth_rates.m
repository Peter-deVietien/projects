% https://www.nicd.ac.za/diseases-a-z-index/disease-index-covid-19/surveillance-reports/daily-hospital-surveillance-datcov-report/
clear

%%
load_nicd_SA

%%

hospdod=[];
for i=7:size(hosp,1)
    hospdod(i)=max((mean(hosp(i-2:i,3))/mean(hosp(i-5:i-3,3))-1)*100,0);
end

for i=7:size(hosp,1)
    icudod(i)=max((mean(hosp(i-2:i,4))/mean(hosp(i-5:i-3,4))-1)*100,0);
end

%yyaxis left
plot(dates,hospdod,'linewidth',5)
ylabel('Growth Rate [%]')

hold on
plot(dates,icudod,'linewidth',5)
hold off

%%
load_owid_data

country='South Africa';
sel=ismember(t.location,country);
dates=t.date(sel);

cma=14;
dma=14;

% Remove nans
seln=isnan(t.new_cases);
t.new_cases(seln)=0;
t.new_deaths(seln)=0;

cases=moving_average(dates,t.new_cases(sel),cma);
deaths=moving_average(dates,t.new_deaths(sel),dma);

casedod=zeros(numel(cases),1);

for i=7:numel(cases)
    casedod(i)=max((mean(cases(i-2:i))/mean(cases(i-5:i-3))-1)*100,0);
end

for i=7:size(cases)
    deathdod(i)=max((mean(deaths(i-2:i))/mean(deaths(i-5:i-3))-1)*100,0);
end

hold on
plot(dates,casedod,'linewidth',5)
hold off

%
ax=gca;
ax.FontSize=18;
ax.XTick=dates(end-50:end)+1;
ax.XTickLabel=datestr(ax.XTick,'mmm dd');


xlim([datetime(2021,11,25)-0.5 datetime+0.5])

% y_lim=ylim;
% ylim([0 y_lim(2)])
% 
fig=gcf;
fig.Position=[83 185 571 506];

grid on

title_str=sprintf('South African COVID\n3 Day Growth Rate');
title(title_str)

%

text(datetime(2021,11,27),52,'www.nicd.ac.za','fontsize',16)
text(datetime(2021,11,27),46,'@peterdevietien','fontsize',16)

legend('Hospitalizations','ICU','Cases')

%
print('~/projects/covid/post/omicron/percent_change_SA','-dpng','-r250')