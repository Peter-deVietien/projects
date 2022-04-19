clear
close all

%%
[dates,revenue]=load_sp500_revenue;

%%

fig=gcf;
fig.Position=[488.00 291.40 919.00 470.60];

plot(dates,revenue,'linewidth',3)

grid on
ax=gca;
ax.XGrid='off';
ax.FontSize=15;

ylabel('Revenue [$bn]')

title('S&P500 Revenue')

xl=xlim;
xlim([xl(1) xl(2)+calmonths(6)])

%%
print('post/sp500_revenue','-dpng')