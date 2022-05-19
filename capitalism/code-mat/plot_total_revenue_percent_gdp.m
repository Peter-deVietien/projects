cca

%%
[yearf,revenue_fed]=load_federal_revenue_percent_gdp;
[years,revenue_state]=load_state_revenue_percent_gdp;
[yearl,revenue_local]=load_local_revenue_percent_gdp;

assert(isequal(yearf,years) & isequal(years,yearl));

year=yearf;

%%

fig=gcf;
fig.Position=[298 382 1096 484];

p(3)=plot(year,revenue_fed+revenue_state+revenue_local,'linewidth',3);

hold on
p(2)=plot(year,revenue_fed+revenue_state,'linewidth',3);
p(1)=plot(year,revenue_fed,'linewidth',3);
hold off

ylabel('Percent of GDP')

%%
grid on
ax=gca;
ax.XGrid='off';
ax.FontSize=20;
ax.XTick=[datetime(1776,1,1), datetime(1800,1,1):calyears(25):datetime(2025,1,1)]
%ax.Position=[0.1300 0.1189 0.7750 0.7381];

xlim([datetime(1775,1,1) datetime(2026,1,1)])
ylim([0 40])

lgn=legend(p,'Federal','Federal + State','Federal + State + Local');
lgn.Position=[0.1471 0.7016 0.2089 0.1436];

title(['Total Tax Revenue U.S.A.',newline,'Percent of GDP'])

text(0.7,0.035,'www.usgovernmentrevenue.com','fontsize',16,'units','normalized')

%%
print('~/projects/capitalism/post/total_revenue_percent_gdp','-dpng')