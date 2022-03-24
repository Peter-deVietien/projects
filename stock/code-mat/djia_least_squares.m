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

plot(dates,lp,'b')

%% Plot least squares
dls = [];
for i=1:numel(dates)
    dls(i)=days(dates(i)-dates(1));
end

[yo,mo,x,bo]=least_squares(lp,dls);

hold on
plot(dates(1)+x,yo,'linewidth',2)
hold off

%% Calc annual rate

annual_rate=365*(exp(mo)-1);

%%
grid on
ylabel('ln(price/price0)')

lgn=legend('Logarithm of SP500 Price','Least Squares Fit');
lgn.Position=[0.2543 0.5320 0.1513 0.0850];

title('Dow Jones History')

%legend('S&P 500','autoupdate','off')

ax=gca;
ax.FontSize=18;


fig=gcf;
fig.Position=[13 233 1500 633];

xlim([datetime(1948,1,1) datetime(2024,1,1)])

%%
print('~/projects/stock/post/djia_least_squares','-dpng')