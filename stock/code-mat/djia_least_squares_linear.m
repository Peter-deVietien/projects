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

plot(dates,price,'b')

%% Plot least squares
dls=days(dates-dates(1));

[yo,mo,x,bo]=least_squares(dls,lp);

hold on
plot(dates(1)+x,exp(yo)*price(1),'linewidth',2)
hold off

%% Calc annual rate

annual_rate=365*(exp(mo)-1);

%%
grid on
%ylabel('')

lgn=legend('DJIA','Least Squares Fit');
lgn.Position=[0.2543 0.5320 0.1513 0.0850];

title(sprintf('Dow Jones Industiral Average and\n 70 Year Least Squares Fit'))

%legend('S&P 500','autoupdate','off')

ax=gca;
ax.FontSize=18;

fig=gcf;
fig.Position=[23 367 1500 500];

xlim([datetime(1948,1,1) datetime(2024,1,1)])

y_lim=ylim;
ytickformat('%,.0d')
ax.YAxis(1).Exponent=0;

yyaxis right

ylim(y_lim)
ytickformat('%,.0d')
ax.YAxis(2).Exponent=0;
ax.YAxis(2).Color='k';





%%
print('~/projects/stock/post/djia_least_squares_linear','-dpng')