cca

t=readtable('~/projects/capitalism/data/real_median_personal_income_2020.xls');

dates=t.MEPAINUSA672N+calmonths(6);
income=t.RealMedianPersonalIncomeInTheUnitedStates_2020CPI_U_RSAdjustedD;

%%
bar(dates,income)

ylabel('Real Income [2020 USD]')
%%
fig=gcf;
fig.Position=[232 312 948 554];


ax=gca;
ax.FontSize=18;
ytickformat('%,.0d')
y_lim=[26000 40000];
ax.YAxis(1).Exponent=0;

ylim(y_lim)
yticks=ax.YTick;

yyaxis right

ax=gca;
ax.YTick=yticks;
ax.YAxis(2).Exponent=0;
ax.YAxis(2).Color='k';
ylim(y_lim)
ytickformat('%,.0d')

grid on

ylim(y_lim)

%%

if 1
   hold on
   %plot([datetime(2001,1,1) datetime(2001,1,1)],[0 80000],'m-','linewidth',2)
   plot([datetime(2009,1,1) datetime(2009,1,1)],[0 80000],'r-','linewidth',2)
   plot([datetime(2017,1,1) datetime(2017,1,1)],[0 80000],'r-','linewidth',2)
   %plot([datetime(2021,1,1) datetime(2021,1,1)],[0 80000],'m-','linewidth',2)    
   hold off
end

text(datetime(2003,1,1),39000,'Bush','fontsize',35,'fontname','Times')
text(datetime(2011,1,1),39000,'Obama','fontsize',35,'fontname','Times')
text(datetime(2018,1,1),39000,'Trump','fontsize',35,'fontname','Times')

xlim([datetime(2001,1,1) datetime(2021,1,1)])

text(0.52,-0.09,'Twitter: @peterdevietien  Data: St. Louis Fed','fontsize',18,'units','normalized')
%%

tstr=sprintf('Real Median Personal Income in the United States');
title(tstr,'fontsize',30,'fontname','Times')

%%
filename='real_median_personal_income';
print(sprintf('~/projects/capitalism/post/%s',filename),'-dpng')