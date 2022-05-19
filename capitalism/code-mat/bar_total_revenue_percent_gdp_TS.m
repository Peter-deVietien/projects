cca

%%
[yearf,revenue_fed]=load_federal_revenue_percent_gdp;
[years,revenue_state]=load_state_revenue_percent_gdp;
[yearl,revenue_local]=load_local_revenue_percent_gdp;

assert(isequal(yearf,years) & isequal(years,yearl));

year=yearf;

%%

fig=gcf;
fig.Position=[298 501 900 365];

k=[revenue_fed,revenue_state,revenue_local];

b=bar(year,k,'stacked');

ylabel('Percent of GDP')

%%
grid on
ax=gca;
ax.XGrid='off';
ax.FontSize=20;
ax.XTick=[datetime(1776,1,1), datetime(1800,1,1):calyears(25):datetime(2025,1,1)]
%ax.Position=[0.1300 0.1189 0.7750 0.7381];
ax.YTick=[0:5:40];

xlim([datetime(1775,1,1) datetime(2026,1,1)])
ylim([0 40])

lgs={'Federal','Federal + State','Federal + State + Local'};
lgn=legend(flip(b),flip(lgs));
lgn.Position=[0.1477 0.4398 0.2544 0.1904];

tt=title(['Total U.S. Tax Revenue',newline,'Percent of GDP'],'fontsize',24);
tt.Position=[3.9762e+04 22.2511 0];

t=text(0.75,0.035,'www.usgovernmentrevenue.com','fontsize',14,'units','normalized');
t.Position=[0.0378 0.3779 0];
%%
print('~/projects/capitalism/post/total_revenue_percent_gdp_TS','-dpng','-r300')