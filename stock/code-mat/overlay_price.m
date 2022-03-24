
%%
d=load_ticker_data(ticker);

if ~exist('plt_color','var')
    plt_color=ax.ColorOrder(ax.ColorOrderIndex,:);
end

%% Normalize if wanted
if exist('norm_date','var')
    old_dates=d.dates_full;
    old_price=d.price;
    [n_ind,~]=find(dates_full>norm_date,1,'first');
    [o_ind,~]=find(old_dates>norm_date,1,'first');
    price=price*old_price(o_ind)/price(n_ind);
end

%% Plot
nplot=numel(h);
hold on
h(nplot+1)=plot(d.dates_full,d.price,'color',plt_color);
hold off
lgs=[lgs {sprintf('%s Price',ticker')}];

%%
lgn=legend(h,lgs);