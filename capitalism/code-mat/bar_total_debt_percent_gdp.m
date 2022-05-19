cca

%%
[yearf,debt_fed]=load_federal_debt_percent_gdp;
[years,debt_state]=load_state_debt_percent_gdp;
[yearl,debt_local]=load_local_debt_percent_gdp;

assert(isequal(yearf,years) & isequal(years,yearl));

year=yearf;

%%

fig=gcf;
fig.Position=[298 382 1096 484];

k=[debt_fed,debt_state,debt_local];

b=bar(year,k,'stacked');

ylabel('Percent of GDP')

%%
grid on
ax=gca;
ax.XGrid='off';
ax.FontSize=20;
ax.XTick=[datetime(1776,1,1), datetime(1800,1,1):calyears(25):datetime(2025,1,1)]
%ax.Position=[0.1300 0.1189 0.7750 0.7381];
ax.YTick=[0:25:150];

xlim([datetime(1775,1,1) datetime(2026,1,1)])
ylim([0 150])


lgs={'Federal','Federal + State','Federal + State + Local'};
lgn=legend(flip(b),flip(lgs));
lgn.Position=[0.1471 0.7016 0.2089 0.1436];

title(['Total U.S. Government Debt',newline,'Percent of GDP'])

t=text(0.7,0.035,'@peterdevietien    www.usgovernmentrevenue.com','fontsize',15,'units','normalized');
t.Position=[-0.0275 -0.1102 0];

%%
print('~/projects/capitalism/post/total_debt_percent_gdp','-dpng')