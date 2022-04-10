clear
close all

%%
load_sp500_energy_revenue
d=load_ticker_data('OIH');
d.price=smoothdata(d.price,'gaussian',20);
%%

fig=gcf;
fig.Position=[488 293.4000 919 468.6000];

plot(dates,revenue,'linewidth',3,'color','blue')

ylabel('Revenue [$bn]')

yyaxis right

p=plot(d.dates_full,d.price,'linewidth',2);
p.Color(4)=0.6;

ylabel('$OIH Price')

grid on
ax=gca;
ax.XGrid='off';
ax.FontSize=15;
ax.YTick=[0:250:1500];
ax.Position=[0.1300 0.1263 0.7750 0.7987];

ax.YAxis(1).Color='b';

title('S&P500 Energy Revenue and $OIH')

xl=xlim;
xlim([xl(1) xl(2)+calmonths(6)])

text(0.51,-0.12,'Twitter: @peterdevietien   Data: Bloomberg','fontsize',14,'units','normalized')

print('post\sp500_energy_revenue_OIH','-dpng')