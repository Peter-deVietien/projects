cca
ticker='^GSPC';


d=load_ticker_data(ticker);

price=d.price;
dates=d.dates_full;

sel=price==0;

price(sel)=[];
dates(sel)=[];


%% Calc least squares
lp=log(price/price(1));

dls=days(dates-dates(1));

[yo,mo,x,bo]=least_squares(dls,lp);

trend=exp(yo)*price(1);

percent_change=(price./trend-1)*100;

fig=figure;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

p(1)=plot(dates(1)+x,percent_change,'color','b');

hold on
plot([dates(1)-2000,dates(end)+2000],[0,0],'k-')
p(2)=plot([dates(1) dates(end)],[1 1]*percent_change(end),'r','linewidth',0.2);
hold off
p(2).Color(4)=0.6;

ylabel('Percent from Trend')

y_lim=[-80 120];
ytick=[-100:20:120];
ylim(y_lim)
ax=gca;
ax.YTick=ytick;


yyaxis right

ylim(y_lim)
ylabel('Percent from Trend')

ax=gca;
ax.YAxis(2).Color='k';
%% Calc annual rate

annual_rate=365*(exp(mo)-1);

%%
grid on
ax=gca;
ax.FontSize=14;

title('S&P 500 Percent Change from 70 Year Trend','Fontsize',18)

ax.YTick=ytick;
ax.XGrid='off';


xlim([datetime(1948,1,1) datetime(2024,1,1)])

lgn=legend(p,'Percent Change','Today''s Value');
lgn.Position=[0.1375 0.8041 0.2208 0.1024];

t1=text(0.5324,-0.1073,'Truth Social: @pdv   Twitter: @peterdevietien','fontsize',11,'units','normalized');
t2=text(0.68,0.075,sprintf('Includes %s',datestr(dates(end),'mmm dd yyyy')),'fontsize',11,'units','normalized','horizontalalignment','center');
t3=text(0.68,0.025,'Percent change from 70 year exponential least squares fit','fontsize',11,'units','normalized','horizontalalignment','center');

%%
print('~/projects/stock/post/sp500_percent_deviation','-dpng')