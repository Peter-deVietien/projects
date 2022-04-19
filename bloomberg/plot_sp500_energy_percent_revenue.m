clear
close all

%%
[dates,revenue]=load_sp500_revenue;
[edates,erevenue]=load_sp500_energy_revenue;

%% Get same starting point

sdate=max(dates(1),edates(1));
sel=dates>=sdate;
dates=dates(sel);
revenue=revenue(sel);

sel=edates>=sdate;
edates=edates(sel);
erevenue=erevenue(sel);

sedates=dates;
serevenue=dspline(edates,erevenue,sedates);

ratio=serevenue./revenue*100;

%%
fig=gcf;
fig.Position=[488.00 291.40 919.00 470.60];

plot(dates,ratio,'linewidth',3)

grid on
ax=gca;
ax.XGrid='off';
ax.FontSize=15;

ylim([0 35])
yticks=[0:5:35];
ax.YTick=yticks;

ylbl=[];
for i=1:numel(yticks)
    ylbl=[ylbl {sprintf('%.0f%%',yticks(i))}];
end

ax.YTickLabel=ylbl;


ylabel('Percent of Revenue')

title('Energy Percent of S&P500 Revenue')

xl=xlim;
xlim([xl(1) xl(2)+calmonths(6)])

%%
print('post/sp500_energy_percent_revenue','-dpng')