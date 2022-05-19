cca

%%
[yearf,revenue_fed]=load_federal_revenue_percent_gdp;
[years,revenue_state]=load_state_revenue_percent_gdp;
[yearl,revenue_local]=load_local_revenue_percent_gdp;

assert(isequal(yearf,years) & isequal(years,yearl));

year=yearf;

%%

fig=gcf;
scale=1;
fig.Position=[75.8000 342 640/scale 360/scale];

k=[revenue_fed,revenue_state,revenue_local];

b=bar(year,k,'stacked');

ylabel('Percent of GDP')

%%
grid on
ax=gca;
ax.XGrid='off';
ax.FontSize=16;
ax.XTick=[datetime(1776,1,1), datetime(1800,1,1):calyears(25):datetime(2025,1,1)]
%ax.Position=[0.1300 0.1189 0.7750 0.7381];
ax.YTick=[0:5:40];

xlim([datetime(1775,1,1) datetime(2026,1,1)])
ylim([0 40])

lgs={'Federal','Federal + State','Federal + State + Local'};
lgn=legend(flip(b),flip(lgs));
lgn.Position=[0.1625 0.5315 0.3192 0.1706];

tt=title(['U.S. Tax Revenue as a Percent of GDP'],'fontsize',18);
tt.Position=[3.7790e+04 35.7641 0];

t1=text(0.75,0.035,'www.usgovernmentrevenue.com','fontsize',12,'units','normalized','horizontalalignment','center');
t1.Position=[0.2484 0.48 0];

t2=text(0.75,0.025,'@peterdevietien','fontsize',12,'units','normalized','horizontalalignment','center');
t2.Position=[0.2484 0.4299 0];

%%
print('~/projects/capitalism/post/total_revenue_percent_gdp_FB','-dpng','-r300')