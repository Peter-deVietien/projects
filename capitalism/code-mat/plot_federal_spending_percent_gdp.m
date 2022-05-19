cca

%%
[year1,deficit]=load_federal_deficit_percent_gdp;
[year2,revenue]=load_federal_revenue_percent_gdp;

assert(isequal(year1,year2));

year=year1;
spending=deficit+revenue;

%%

fig=gcf;
fig.Position=[298 454 1073 412];

plot(year,revenue,'linewidth',3)

hold on
plot(year,spending,'linewidth',3)
hold off

ylabel('Percent of GDP')

%%
grid on
ax=gca;
ax.XGrid='off';
ax.FontSize=20;
%ax.Position=[0.1300 0.1189 0.7750 0.7381];

xlim([datetime(1790,1,1) datetime(2024,1,1)])
ylim([0 32])

lgn=legend('Federal Revenue','Federal Spending');
lgn.Position=[0.1524 0.6930 0.1710 0.1153];

title(['Federal Revenue and Spending',newline,'Percent of GDP'])

text(0.7,0.035,'www.usgovernmentrevenue.com','fontsize',16,'units','normalized')

%%
print('~/projects/capitalism/post/federal_spending_percent_gdp','-dpng')