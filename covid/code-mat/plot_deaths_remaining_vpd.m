cca
load('data/percent_deaths_remaining.mat')

%%
start_date=datetime(2020,12,10);
days=start_date:caldays(1):start_date+caldays(ndays-1);

%%
plot(days,v_perc*100,'linewidth',8)

%%
ylabel('Percentage of Daily COVID deaths')
title_str=sprintf('Reduction in COVID Daily Deaths from Vaccines\n\nCalculated from: CDC COVID age-death data and 2018 US Age Census\n Assuming: 50/50 mix of Pfizer and Moderna vaccines\n 55%% efficacy 10 days after shot 1, and 95%% efficacy 10 days after booster shot');
title(title_str)

datetick('x','mmm-dd')
xlim([days(1) days(end-60)])
ylim([0 100])

%%
yyaxis right
scatter(days,vaccines_per_day/1000,'linewidth',4)

ylim([0 2.1])
ylabel('Vaccines administered per day [millions]')
ytickformat('%.1f')

%%
ax=gca;
ax.FontSize=20;
grid on
fig=gcf;
fig.Position=[1 109 1309 689];

%%
text(datetime(2021,1,10),.350,'@peterdevietien','fontsize',25)

%%
print('post/remaining_deaths','-dpng')