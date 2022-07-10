cca

%%

[gdates,gprice]=load_gold_historical_prices_usd;
[dates,price_no_div,price_div]=load_sp500_historical_prices();

%% get common dates

[~,cprice]=dspline(gdates,gprice,dates);

%%
leftycolor=[0 0.4470 0.7410];
rightycolor=[0.8500 0.3250 0.0980];


subplot(2,1,1)


p(1)=semilogy(dates,price_div,'linewidth',1,'color',leftycolor);

hold on
pt=plot([dates(1) dates(end)],[1 1]*price_div(end),'r-');
pt.Color(4)=0.5;
hold off

%%
grid on
ax=gca;
ax.FontSize=15;

title(['S&P 500 Priced in Nominal USD (dividends reinvested)'],'Fontsize',18)

ax.XGrid='off';

ax.YTick=[10 100 1000 10000 100000];
ax.YTickLabel={'10','100','1,000','10,000','100,000'};

ylim([10 200000]) 
xlim([datetime(1949,1,1) datetime(2024,1,1)])

ind=find(dates>datetime(1949,1,1),1,'first');


%%
subplot(2,1,2)

ratio=price_div./cprice;

p(1)=semilogy(dates,ratio,'linewidth',1,'color',leftycolor);

hold on
pt=plot([dates(1) dates(end)],[1 1]*ratio(end),'r-');
pt.Color(4)=0.5;
hold off



%%
grid on
ax=gca;
ax.FontSize=15;

title(['S&P 500 Priced in ounces of Gold (dividends reinvested)'],'Fontsize',18)

ax.XGrid='off';

ax.YTick=[1 3 10 30 100];
ax.YTickLabel={'1','3','10','30','100'};
xlim([datetime(1949,1,1) datetime(2024,1,1)])

t1=text(-0.001,-0.2538,['Last Date: ',datestr(dates(end),'dd-mmm-yyyy')],'fontsize',12,'units','normalized');
t2=text(0.5594,-0.2428,'Truth Social: @pdv   Twitter: @peterdevietien','fontsize',12,'units','normalized');

fig=gcf;
fig.Position=[476 330 698 536];


%%
print('~/projects/stock/post/sp500_vs_gold_usd_divs_log_subplt','-dpng')