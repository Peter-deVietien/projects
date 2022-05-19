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
ax.FontSize=20;
ax.XTick=[datetime(1776,1,1), datetime(1800,1,1):calyears(25):datetime(2025,1,1)]
%ax.Position=[0.1300 0.1189 0.7750 0.7381];
ax.YTick=[0:20:140];

xlim([datetime(1775,1,1) datetime(2026,1,1)])
%ylim([0 40])

lgs={'Federal','Federal + State','Federal + State + Local'};
lgn=legend(flip(b),flip(lgs));
lgn.Position=[0.1391 0.4734 0.3817 0.2062];

tt=title(['Total U.S. Govt. Debt',newline,'Percent of GDP'],'fontsize',24);
tt.Position=[3.7790e+04 116.8175 0];

t=text(0.75,0.035,'www.usgovernmentrevenue.com','fontsize',14,'units','normalized','horizontalalignment','center');
t.Position=[0.2484 0.3779 0];

t=text(0.75,0.025,'@peterdevietien','fontsize',14,'units','normalized','horizontalalignment','center');
t.Position=[0.2484 0.3190 0];

%%
print('~/projects/capitalism/post/total_debt_percent_gdp_post','-dpng','-r300')