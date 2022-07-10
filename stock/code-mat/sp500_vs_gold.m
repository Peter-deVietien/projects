%cca
figure
%%
ticker='^GSPC';
d=load_ticker_data(ticker);
dates=d.dates_close;
price=d.close;

[gdates,gprice]=load_gold_historical_prices_usd;

%% get common dates

[~,cprice]=dspline(gdates,gprice,dates);

%%
leftycolor=[0 0.4470 0.7410];
rightycolor=[0.8500 0.3250 0.0980];

fig=figure;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

ratio=price./cprice;

p(1)=plot(dates,ratio,'linewidth',1,'color',leftycolor);

hold on
pt=plot([dates(1) dates(end)],[1 1]*ratio(end),'r-');
pt.Color(4)=0.5;
hold off

%%
grid on
ax=gca;
ax.FontSize=15;

title(['S&P 500 in ounces of Gold'],'Fontsize',18)

ax.XGrid='off';


xlim([datetime(1949,1,1) datetime(2024,1,1)])

t1=text(0.0151,0.0382,['Last Date: ',datestr(dates(end),'dd-mmm-yyyy')],'fontsize',12,'units','normalized');
t2=text(0.5266,-0.1088,'Truth Social: @pdv   Twitter: @peterdevietien','fontsize',11,'units','normalized');

%%
print('~/projects/stock/post/sp500_vs_gold','-dpng')