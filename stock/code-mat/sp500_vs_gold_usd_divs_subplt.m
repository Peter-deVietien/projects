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


p(1)=plot(dates,price_div,'linewidth',1,'color',leftycolor);

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

ax.YTick=[0,2,4,6,8,10,12]*1e4;
ax.YTickLabel={'0','20,000','40,000','60,000','80,000','100,000','120,000'};
xlim([datetime(1949,1,1) datetime(2024,1,1)])

ind=find(dates>datetime(1949,1,1),1,'first');

tt1=text(.0372,.3159,sprintf('Price: $%.2f',price_div(ind)),'units','normalized','fontsize',12);
a1=annotation('arrow',[.03 .03],[.7 .6]);
a1.X=[0.1920 0.1403];
a1.Y=[0.6698 0.5981];



%%
subplot(2,1,2)

ratio=price_div./cprice;

p(1)=plot(dates,ratio,'linewidth',1,'color',leftycolor);

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


xlim([datetime(1949,1,1) datetime(2024,1,1)])

t1=text(-0.001,-0.2538,['Last Date: ',datestr(dates(end),'dd-mmm-yyyy')],'fontsize',12,'units','normalized');
t2=text(0.5594,-0.2428,'Truth Social: @pdv   Twitter: @peterdevietien','fontsize',12,'units','normalized');

tt2=text(.0298,0.3333,sprintf('Price: %.2f oz',ratio(ind)),'units','normalized','fontsize',12);
a2=annotation('arrow',[.03 .03],[.3 .2]);
a2.X=[0.1905 0.1404];
a2.Y=[0.1959 0.1231];

fig=gcf;
fig.Position=[476 330 698 536];


%%
print('~/projects/stock/post/sp500_vs_gold_usd_divs_subplt','-dpng')