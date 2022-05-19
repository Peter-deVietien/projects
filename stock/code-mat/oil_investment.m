cca

ticker='XOP';

d=load_ticker_data(ticker);

%%

dates=d.dates_full;
price=d.price;

%%
fig=gcf;
fig.Position=[341 309 1026 557];

plot(dates,price,'linewidth',2)

%%

ylabel('$XOP')

grid on

ax=gca;
ax.FontSize=20;
xlim([datetime(2020,2,1) dates(end)+calmonths(2)])
ax.YTick=[0:25:150];


%%

k=readtable('../../taxes/data/trades_2020_2021.xlsx');
sec=k.Security;

seclist={'MRO','OIH','CVE','XOP','CVX','OXY','XLE','MRO','USO','DVN','RIG'};

sel=zeros(numel(sec),1);
lisel=false(numel(sec),1);
for i=1:numel(seclist)
    isel=regexp(sec,seclist{i});
    for j=1:numel(isel)
        if isel{j}==1
            lisel(j)=true;
        end
    end
    
end

tdates=[];
for i=1:numel(lisel)
    if lisel(i)
        tdates=[tdates; datetime(k.TradeDate{i},'format','MM/dd/yyyy')];
    end
end

udates=unique(tdates);

for i=1:numel(udates)
    dt=udates(i);
    ind=find(dates>dt,1,'first');
    
    hold on
    plot([dt dt],[0 price(ind)],'k--')
    hold off
end




title(sprintf('PdV Oil Equity Purchase/Sell Dates\n$XOP for illustration'),'fontsize',22);

print('../post/oil_investment','-dpng')