cca

%%
[yearf,revenue_fed]=load_federal_revenue_percent_gdp;
[years,revenue_state]=load_state_revenue_percent_gdp;
[yearl,revenue_local]=load_local_revenue_percent_gdp;

assert(isequal(yearf,years) & isequal(years,yearl));

year=yearf;

%%

fig=gcf;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

k=[revenue_fed,revenue_state,revenue_local];

b=bar(year,k,'stacked');

ylabel('Percent of GDP')

%%
grid on
ax=gca;
ax.XGrid='off';
ax.FontSize=16;
ax.XTick=[datetime(1776,1,1), datetime(1800,1,1):calyears(25):datetime(2000,1,1), datetime(2022,1,1)]
%ax.Position=[0.1300 0.1189 0.7750 0.7381];
ax.YTick=[0:5:40];

xlim([datetime(1775,1,1) datetime(2026,1,1)])
ylim([0 40])

lgs={'Federal','State','Local'};
lgn=legend(flip(b),flip(lgs));
lgn.Position=[0.1458 0.6056 0.1730 0.1556];

tt=title(['U.S. Tax Revenue as a Percent of GDP'],'fontsize',18,'units','normalized');
tt.Position=[.5 .9074 0];

t1=text(0.8253,1.0326,'www.usgovernmentrevenue.com','fontsize',11,'units','normalized','horizontalalignment','center');
t2=text(0.0791,1.0326,'@peterdevietien','fontsize',11,'units','normalized','horizontalalignment','center');

%%
print('~/projects/capitalism/post/total_revenue_percent_gdp','-dpng','-r300')