
cca

%% Load
reload=1;
if reload
    tickers={'^GSPC','DJI','^STOXX'};
    labels={'S&P 500','Dow Jones','STOXX Europe 600'};

    d=struct();
    nt=numel(tickers);

    for i=1:nt
        data=load_ticker_data(tickers{i});
        d(i).dates_full=data.dates_full;
        d(i).price=data.price;
        d(i).label=labels{i};

        %% Do YoY
        sel=d(i).price==0;
        d(i).price(sel)=[];
        d(i).dates_full(sel)=[];
        
        dates=d(i).dates_full;
        price=d(i).price;    


        
        nd=numel(dates);
        yoy=nan(nd,1);
        is=find(dates>(dates(1)+years(5)),1,'first');
        for iy=is:nd
            yaind=find(dates>(dates(iy)-years(5)),1,'first');
            yoy(iy)=price(iy)/price(yaind)-1;
        end
        d(i).yoy=yoy;

    end
    save('~/projects/stock/data/indicies_yoy','d')
else
    load('~/projects/stock/data/indicies_yoy')
end
%%
nt=numel(d);
lgs=[];

plot([d(1).dates_full(1)-years(5),d(1).dates_full(end)+years(5)],[0 0],'k-','linewidth',0.5)

for i=1:nt
    dates=d(i).dates_full;
    yoy=d(i).yoy*100;
    
    yoyma=moving_average(dates,yoy,60);
    
    hold on
    
    alpha=1;
    linewidth=2;
    if i==11
        alpha=1;
        linewidth=4;
        linecolor=[0.4660 0.6740 0.1880];
    end
    
    if i==4
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

lgn=legend(p,lgs);
%lgn.Position=[0.4434 0.6775 0.3113 0.1860];

xlim([datetime(1970,1,1) datetime()+calmonths(2)])

y_lim=[-40 250];
ylim(y_lim);
yticks=ax.YTick;

ylabel('YoY Percent Change')

yyaxis right

ylim(y_lim);
ax.YTick=yticks;
ax.YAxis(2).Color='k';

title_str=sprintf('Trailing Five Year Return\nFor Major Indicies',datestr(d(end).dates_full(end),'dd mmm yyyy'));
title(title_str);

text(datetime(2020,1,1),-125,'@peterdevietien','fontsize',17);

filename='sp500_sectors_yoy';
print(sprintf('~/projects/stock/post/%s',filename),'-dpng')