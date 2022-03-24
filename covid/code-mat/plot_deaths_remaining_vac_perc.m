cca
load('data/percent_deaths_remaining.mat')

%%
vax_perc=cumsum(vaccines_per_day)/sum(pop_bins);

start_date=datetime(2020,12,10);
days=start_date:caldays(1):start_date+caldays(ndays-1);

%%
plot(days,v_perc*100,'linewidth',8)

%%
ylabel('Percentage of Daily COVID deaths')


datetick('x','mmm-dd')
xlim([days(1) days(end-60)])
ylim([0 100])

%%
text(datetime(2021,2,02),85,'@peterdevietien','fontsize',25)

text(datetime(2021,2,20),48,sprintf('Daily deaths should permanently \ndecrease 50%% after 10%% of\nthe US is vaccinated (Early Feb)'),'fontsize',25);

text(datetime(2020,12,13),12,sprintf('X''s are real world data\n0.84%% as of Dec 29th'),'fontsize',20)

text(datetime(2020,12,12),50,sprintf('                            Assumptions:\n1) 50/50 mix of Pfizer and Moderna vaccines\n2) 55%% efficacy linearly 10 days after first shot\n    95%% efficacy linearly 10 days after second shot\n\nVaccines administered data from ourworldindata.org/covid-vaccinations\nPopulation data from 2018 US Census\nCOVID Deaths-age data from CDC Feb 1st - Dec 16th'),'fontsize',13);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
yyaxis right
scatter(days,vax_perc*100,'linewidth',4)

ylim([0 25])
ylabel('Percent of US population vaccinated')

%%
% hold on
% plot([datetime(2021,2,6) datetime(2021,2,6)],[0 100],'k-')
% hold off

k=annotation('ellipse',[.5 .5 .05 .05]);
k.Position=[0.4700 0.4300 0.1200 0.1200];

hold on
scatter(datetime(2020,12,19),0.08,800,'xk')
scatter(datetime(2020,12,20),0.17,800,'xk')
scatter(datetime(2020,12,22),0.30,800,'xk')
scatter(datetime(2020,12,25),0.59,800,'xk')
scatter(datetime(2020,12,27),0.64,800,'xk')
scatter(datetime(2020,12,29),0.84,800,'xk')
hold off

%%
ax=gca;
ax.FontSize=25;
grid on
fig=gcf;
fig.Position=[1 97 1309 701];

title_str=sprintf('Expected Reduction in Daily COVID Deaths from Vaccines');
title(title_str,'fontsize',33)

%%
print('post/remaining_deaths','-dpng')