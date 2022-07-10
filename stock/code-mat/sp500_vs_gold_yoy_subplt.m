cca

%%
ticker='^GSPC';
d=load_ticker_data(ticker);
dates=d.dates_close;
price=d.close;

[gdates,gprice]=load_gold_historical_prices_usd;

%% get common dates

[~,cprice]=dspline(gdates,gprice,dates);

ratio=price./cprice;

%%
rat_yoy=nan(numel(dates),1);
dates_yoy=NaT(numel(dates),1);

if 0
for i=numel(dates):-1:360
    ind=find(dates>(dates(i)-calyears(1)),1,'first');
    rat_yoy(i)=ratio(i)/ratio(ind);
    dates_yoy(i)=dates(i);
end
    save('gold_sp500_rat.mat','dates_yoy','rat_yoy')
else
    load('gold_sp500_rat.mat')
end

%%
leftycolor=[0 0.4470 0.7410];
rightycolor=[0.8500 0.3250 0.0980];

fig=figure;
scale=2;
fig.Position=[476 195 744 671];

subplot(2,1,1)
plot(dates,ratio,'linewidth',1,'color',leftycolor)

hold on
pt=plot([dates(1) dates(end)],[1 1]*ratio(end),'r-');
pt.Color(4)=0.7;
hold off

grid on
ax=gca;
ax.FontSize=15;
xlim([datetime(1949,1,1) datetime(2024,1,1)])
ax.XGrid='off';


title(['S&P 500 priced in ounces of gold'],'Fontsize',18)


subplot(2,1,2)

plot([datetime(1800,1,1) datetime(2030,1,1)],[0 0],'k-','linewidth',0.5)

hold on
p(1)=plot(dates_yoy,(rat_yoy-1)*100,'linewidth',1,'color',leftycolor);
hold off
%%
grid on
ax=gca;
ax.FontSize=15;

title(['S&P 500 priced in ounces of gold, YoY'],'Fontsize',18)

ax.XGrid='off';


xlim([datetime(1949,1,1) datetime(2024,1,1)])

t1=text(0.0151,0.0382,['Last Date: ',datestr(dates(end),'dd-mmm-yyyy')],'fontsize',12,'units','normalized');
t2=text(0.6167,-0.2663,'Truth Social: @pdv   Twitter: @peterdevietien','fontsize',11,'units','normalized');

%%
a1=annotation('line',[1 1]*0.4153,[0.11 .923]);
a2=annotation('line',[1 1]*0.6626,[0.11 .923]);

%%
print('~/projects/stock/post/sp500_vs_gold_yoy_subplt','-dpng')