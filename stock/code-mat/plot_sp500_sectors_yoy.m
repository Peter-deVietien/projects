
cca

%% Load
reload=0;
if reload
    tickers={'XLK','XLV','XLY','XLC','XLF','XLI','XLP','XLU','XLB','XLRE','XLE'};
    labels={'Information Technology','Health Care','Consumer Discretionary','Communication Services','Financials','Industrials',...
        'Consumer Staples','Utilities','Materials','Real Estate','Energy'};
    

    d=struct();
    nt=numel(tickers);

    for i=1:nt
        data=load_ticker_data(tickers{i});
        d(i).dates_full=data.dates_full;
        d(i).price=data.price;
        d(i).label=labels{i};

        %% Do YoY
        dates=d(i).dates_full;
        price=d(i).price;    

        nd=numel(dates);
        yoy=nan(nd,1);
        for iy=1000:nd
            yaind=find(dates>(dates(iy)-years(1)),1,'first');
            yoy(iy)=price(iy)/price(yaind)-1;
        end
        d(i).yoy=yoy;

    end
    save('~/projects/stock/data/sp500_sectors_yoy','d')
else
    load('~/projects/stock/data/sp500_sectors_yoy')
end
%%
nt=numel(d);
lgs=[];

plot([d(1).dates_full(1)-years(5),d(1).dates_full(end)+years(5)],[0 0],'k-','linewidth',0.5)

for i=1:nt
    dates=d(i).dates_full;
    yoy=d(i).yoy*100;
    
    yoyma=moving_average(dates,yoy,90);
    
    hold on
    
    alpha=0.3;
    linewidth=1;
    if i==11
        alpha=1;
        linewidth=4;
        linecolor=[0.4660 0.6740 0.1880];
    end
    
    if i==1
        alpha=1;
        linewidth=4;
        linecolor=[0.8500 0.3250 0.0980];
    end
    
    p(i)=plot(dates,yoyma);
    hold off
    
    p(i).LineWidth=linewidth;
    p(i).Color(4)=alpha;
    if (i==11 | i==4)
        p(i).Color(1:3)=linecolor;
    end
    lgs=[lgs {sprintf('%s',d(i).label)}];
end

%%
ax=gca;
ax.FontSize=18;
grid on

fig=gcf;
fig.Position=[90 218 1219 648];

lgn=legend(p,lgs,'numcolumns',2);
lgn.Position=[0.4434 0.6775 0.3113 0.1860];

xlim([datetime(2006,1,1) datetime()+calmonths(2)])

y_lim=[-70 100];
ylim(y_lim);
yticks=ax.YTick;

ylabel('YoY Percent Change')

yyaxis right

ylim(y_lim);
ax.YTick=yticks;
ax.YAxis(2).Color='k';

title_str=sprintf('Year over Year Change for S&P 500 Sectors\nTrailing Three Month Average: Includes %s',datestr(d(end).dates_full(end),'dd mmm yyyy'));
title(title_str);

text(datetime(2020,1,1),-125,'@peterdevietien','fontsize',17);

filename='sp500_sectors_yoy';
print(sprintf('~/projects/stock/post/%s',filename),'-dpng')