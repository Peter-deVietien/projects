clear
close all

%%
[dates,revenue]=load_sp500_revenue;
[edates,erevenue]=load_sp500_energy_revenue;

[mdates,weight]=load_sp500_energy_percent_markcap;

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
leftycolor=[0 0.4470 0.7410];
%%
fig=gcf;
fig.Position=[488.00 291.40 919.00 470.60];

p=plot(dates,ratio,'linewidth',3,'color',leftycolor);
p.Color(4)=0.7;

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


yyaxis right

p=plot(mdates,weight,'linewidth',3);
p.Color(4)=0.5;

ylim([0 15])
yticks=[0:2.5:15];
ax=gca;
ax.YTick=yticks;
ax.YAxis(1).Color=leftycolor;

ylbl=[];
for i=1:numel(yticks)
    ylbl=[ylbl {sprintf('%.1f%%',yticks(i))}];
end

ax.YTickLabel=ylbl;
ax.Position=[0.11 0.1263 0.7750 0.74];

ylabel('Percent of Market Cap')

lgn=legend('Revenue','Market Cap','fontsize',16);
lgn.Position=[0.1307 0.1687 0.1757 0.1218];

title(['S&P500 Energy Sector',newline,'Percent of Revenue and Market Cap'])

xl=xlim;
xlim([xl(1) xl(2)+calmonths(6)])

text(0.51,-0.12,'Twitter: @peterdevietien   Data: Bloomberg','fontsize',14,'units','normalized')

%%
print('post/sp500_energy_percent_revenue_markcap','-dpng')