
cca

%% Load
tickers={'VNQ','XLU','VOX','VGT','XLF','VHT','XLP','VCR','VIS','MXI','VDE'};
labels={'Real Estate','Utilities','Communication','Information Tech','Financials','Health Care','Consumer Staples','Consumer Discretionary','Industrials','Materials','Energy'};

d=struct();

nt=numel(tickers);

for i=1:nt
    data=load_ticker_data(tickers{i});
    d(i).dates_full=data.dates_full;
    d(i).price=data.price;
    d(i).label=labels{i};
end

%%
lgs=[];

for i=1:nt
    dates=d(i).dates_full;
    price=d(i).price;
    
    yaind=find(dates(end)==(dates(end)-years(1)));
    
    yoy=price./price(
    
    if i>1
        hold on
    end
    plot(dates,price)
    hold off
    
    lgs=[lgs {sprintf('%s',labels{i})}];
end

%%
ax=gca;
ax.FontSize=18;
grid on

fig=gcf;
fig.Position=[90 218 1219 648];

lgn=legend(lgs);
lgn.Position=[0.3216 0.6088 0.1772 0.3364];

xlim([datetime(2005,1,1) datetime()+calmonths(2)])