cca
ticker='^GSPC';


d=load_ticker_data(ticker);

price=d.price;
dates=d.dates_full;

sel=price==0;

price(sel)=[];
dates(sel)=[];


%%

lp=log(price/price(1));

%plot(dates,lp,'b')

%% Calc least squares
dls=days(dates-dates(1));

[yo,mo,x,bo]=least_squares(dls,lp);

dy=lp-yo;

factor=(exp(lp(end))*price(1)) / (exp(yo(end))*price(1));

p(1)=plot(dates(1)+x,dy/dy(end)*(factor-1)*100,'color','b');

hold on
plot([dates(1)-2000,dates(end)+2000],[0,0],'k-')
p(2)=plot([dates(1) dates(end)],[1 1]*(factor-1)*100,'r','linewidth',0.2);
hold off
p(2).Color(4)=0.6;
y_lim=ylim;

ylabel('Percent from Trend')

ax=gca;
ax.YTick=[-100:10:100];


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
ax.FontSize=18;

title('S&P 500 Percent Change from 70 Year Trend','Fontsize',28)



ax.YTick=[-100:10:100];
ax.XGrid='off';

fig=gcf;
fig.Position=[13 161 1500 705];

xlim([datetime(1948,1,1) datetime(2024,1,1)])

lgn=legend(p,'Percent Change','Today''s Value','fontsize',22);

text(0.67,-0.1,'Truth Social: @pdv   Twitter: @peterdevietien','fontsize',20,'units','normalized')
text(0.61,0.04,sprintf('Includes %s\nPercent change from 70 year exponential least squares fit',datestr(dates(end),'mmm dd yyyy')),'fontsize',17,'units','normalized')

%%
print('~/projects/stock/post/sp500_percent_deviation','-dpng')