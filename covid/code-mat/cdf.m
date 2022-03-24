cca
load_covid_age_data

death_total=sum(c19deathbins);
deathbin_percent=c19deathbins/death_total;
cudf=cumsum(deathbin_percent)*100;
linages=linspace(ages(1),ages(end),100);

cudf=spline(ages,cudf,linages);

plot(linages,cudf,'linewidth',5)

ind1=65;
hold on
area(linages(ind1:end),cudf(ind1:end))
hold off

ind2=75;

hold on
a2=area(linages(ind2:end),cudf(ind2:end));
hold off
a2.FaceAlpha=0.7;

title_str=sprintf('C19 Deaths in USA by Age\nFeb 1st - Dec 16th.  Data from CDC');
title(title_str,'fontsize',35)

text(30,97,'https://www.cdc.gov/nchs/nvss/vsrr/covid\_weekly/index.htm','fontsize',14)

ax=gca;
ax.FontSize=20;
grid on


fig=gcf;
fig.Position=[440 137 836 661];

%%
usa_age_dist

ind1pop=round(sum(pop_bins(end-(100-ind1):end))/1000,0);
ind2pop=round(sum(pop_bins(end-(100-ind2):end))/1000,0);

tstr=sprintf('People over %d: %.0f%% of daily deaths\n (%dm people, %2.0f%% of pop)',linages(ind1),100-cudf(ind1),ind1pop,ind1pop/3.30);
text(40,60,tstr,'fontsize',25,'horizontalalignment','center')

tstr=sprintf('People over %d: %.0f%% of daily deaths\n (%dm people, %2.0f%% of pop)',linages(ind2),100-cudf(ind2),ind2pop,ind2pop/3.30);
text(40,80,tstr,'fontsize',29,'horizontalalignment','center')

tstr=sprintf('@peterdevietien');
text(05,97,tstr,'fontsize',17);

% tstr=sprintf('-> Our elderly are the\nones at risk');
% text(35,40,tstr,'fontsize',30,'horizontalalignment','center')

ylabel('Percent of Deaths')
xlabel('Age')

print('post/cdf','-dpng')