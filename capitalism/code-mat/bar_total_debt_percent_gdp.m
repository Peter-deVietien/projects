cca

%%
[yearf,debt_fed]=load_federal_debt_percent_gdp;
[years,debt_state]=load_state_debt_percent_gdp;
[yearl,debt_local]=load_local_debt_percent_gdp;

assert(isequal(yearf,years) & isequal(years,yearl));

year=yearf;

%%

fig=gcf;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

k=[debt_fed,debt_state,debt_local];

b=bar(year,k,'stacked');

ylabel('Percent of GDP')

%%
grid on
ax=gca;
ax.XGrid='off';
ax.FontSize=14;
ax.XTick=[datetime(1776,1,1), datetime(1800,1,1):calyears(25):datetime(2000,1,1), datetime(2022,1,1)];
ax.YTick=[0:20:160];

xlim([datetime(1775,1,1) datetime(2026,1,1)])
ylim([0 160])

lgs={'Federal','State','Local'};
lgn=legend(flip(b),flip(lgs));
lgn.Position=[0.1437 0.6222 0.1730 0.1556];

tt=title(['U.S. Govt. Debt as a Percent of GDP'],'fontsize',18,'units','normalized');
tt.Position=[.5 .904 0];

t1=text(0.8253,1.0326,'www.usgovernmentrevenue.com','fontsize',11,'units','normalized','horizontalalignment','center');
t2=text(0.0791,1.0326,'@peterdevietien','fontsize',11,'units','normalized','horizontalalignment','center');

%%
print('~/projects/capitalism/post/total_debt_percent_gdp','-dpng','-r300')