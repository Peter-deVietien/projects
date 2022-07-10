cca

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


subplot(2,1,1)

ratio=price./cprice;

p(1)=plot(dates,price,'linewidth',1,'color',leftycolor);

hold on
pt=plot([dates(1) dates(end)],[1 1]*price(end),'r-');
pt.Color(4)=0.5;
hold off

%%
grid on
ax=gca;
ax.FontSize=15;

title(['S&P 500 in Nominal USD'],'Fontsize',18)

ax.XGrid='off';


xlim([datetime(1949,1,1) datetime(2024,1,1)])


subplot(2,1,2)


p(1)=plot(dates,ratio,'linewidth',1,'color',leftycolor);

hold on
pt=plot([dates(1) dates(end)],[1 1]*ratio(end),'r-');
pt.Color(4)=0.5;
hold off

tt=text(.0372,1.7159,sprintf('Price: $%.2f',price(2)),'units','normalized','fontsize',12);
a1=annotation('arrow',[.03 .03],[.7 .6]);
a1.X=[0.1920 0.1403];
a1.Y=[0.6698 0.5981];

%%
grid on
ax=gca;
ax.FontSize=15;

title(['S&P 500 in ounces of Gold'],'Fontsize',18)

ax.XGrid='off';


xlim([datetime(1949,1,1) datetime(2024,1,1)])

t1=text(-0.001,-0.2538,['Last Date: ',datestr(dates(end),'dd-mmm-yyyy')],'fontsize',12,'units','normalized');
t2=text(0.5594,-0.2428,'Truth Social: @pdv   Twitter: @peterdevietien','fontsize',12,'units','normalized');


fig=gcf;
fig.Position=[476 330 698 536];


%%
print('~/projects/stock/post/sp500_vs_gold_usd_subplt','-dpng')