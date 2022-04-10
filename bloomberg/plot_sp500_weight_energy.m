clear
close all

d=readtable('sp500_energy_weight.csv');
d=sortrows(d);

dates=d.Var1;
weight=d.Var2;

%%

plot(dates,weight,'linewidth',3);

hold on
plot([dates(1) dates(end)],[1 1]*weight(end),'r-')
hold off

ylabel('Percent of S&P500')

%%
fig=gcf;
fig.Position=[117.80 263.80 930.20 498.20];

grid on
ax=gca;
ax.XGrid='off';
ax.FontSize=16;
ax.Position=[0.13 0.14 0.78 0.79];

title('Percent of Investment in S&P500 Energy Sector')

text(0.503,-0.123,'Twitter: @peterdevietien   Data: Bloomberg','fontsize',14,'units','normalized')

