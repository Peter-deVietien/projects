cca
ticker='DJIA';


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
dls = [];
for i=1:numel(dates)
    dls(i)=days(dates(i)-dates(1));
end

[yo,mo,x,bo]=least_squares(lp,dls);

dy=lp-yo;

factor=(exp(lp(end))*price(1)) / (exp(yo(end))*price(1));

plot(dates(1)+x,dy/dy(end)*(factor-1)*100)

hold on
plot([dates(1)-2000,dates(end)+2000],[0,0],'k-')
hold off

y_lim=ylim;

ylabel('Percent Exceeding Trend')

ax=gca;
ax.YTick=[-100:10:100];


yyaxis right

ylim(y_lim)
ylabel('Percent Exceeding Trend')

ax=gca;
ax.YAxis(2).Color='k';
%% Calc annual rate

annual_rate=365*(exp(mo)-1);

%%
grid on

%lgn=legend('Log of SP500 minus trend');
%lgn.Position=[0.2570 0.83 0.1513 0.0850];

title('Dow Jones Percent Deviation From Trailing 70 Year Trend')

%legend('S&P 500','autoupdate','off')

ax=gca;
ax.FontSize=18;

ax.YTick=[-100:10:100];


fig=gcf;
fig.Position=[13 161 1500 705];

xlim([datetime(1948,1,1) datetime(2024,1,1)])

%%
print('~/projects/stock/post/djia_percent_deviation','-dpng')