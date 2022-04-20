clear
close all

%%
[dates,revenue]=load_sp500_energy_revenue;
[mdates,markcap]=load_sp500_energy_markcap();

%%
eind=4;
dates=dates(1:end-eind);
revenue=revenue(1:end-eind);
% mdates=mdates(1:end-eind);
% markcap=markcap(1:end-eind);

[~,rinfl]=inflation_vs_t(dates);
[~,minfl]=inflation_vs_t(mdates);
%%

fig=gcf;
fig.Position=[488 293.4000 919 468.6000];

p=plot(dates,revenue./rinfl,'linewidth',3,'color','blue');
p.Color(4)=0.6;

ylabel('Revenue [$bn]')

yyaxis right

p=plot(mdates,markcap/1e9./minfl,'linewidth',2);
p.Color(4)=0.6;

ylabel('Market Cap [$bn]')

grid on
ax=gca;
ax.XGrid='off';
ax.FontSize=15;
%ax.YTick=[500:300:2600]
ax.Position=[0.1300 0.1263 0.7750 0.7367];

ax.YAxis(1).Color='b';

title(['S&P500 Energy Revenue and Market Cap',newline,'Inflation Adjusted to 2022 USD'])

xl=xlim;
xlim([xl(1) xl(2)+calmonths(6)])

t1=text(0.3,0.12,'Last Market Cap Data: April 1st 2022','fontsize',11','units','normalized');
t2=text(0.3,0.07,'Last Revenue Data: Dec 31st 2021','fontsize',11','units','normalized');

t3=text(0.572,-0.12,'Twitter: @peterdevietien   Data: Bloomberg','fontsize',12,'units','normalized');

print('post\sp500_energy_revenue_markcap','-dpng')