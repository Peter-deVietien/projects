clear;
close all;

load_high_ps;

%%
sel=markcap>5e9;
evsales=evsales(sel);

histogram(evsales,[0:0.5:20])

xlim([0 20])

ylabel('Number of Companies')
xlabel('EV/Sales Ratio')

ax=gca;
ax.FontSize=15;

fig=gcf;
fig.Position=[488.00 342.00 877.40 420.00];

title(sprintf('EV/Sales in Russell 3000 with Market Cap > $5bn'))