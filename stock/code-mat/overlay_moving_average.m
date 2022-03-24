
%%
load_ticker_data

%% Choose color if wanted
if ~exist('plt_color','var')
    ax=gca;
    plt_color=ax.ColorOrder(ax.ColorOrderIndex,:);
end

%% Normalize if wanted
if exist('norm_date','var')
    old_dates=dates_full;
    old_price=price;
    [n_ind,~]=find(dates_full>norm_date,1,'first');
    [o_ind,~]=find(old_dates>norm_date,1,'first');
    price=price*old_price(o_ind)/price(n_ind);
end

%% Plot
nplot=numel(h);
hold on
v_ma=moving_average(dates_full,price,ma_days);
h(nplot+1)=plot(dates_full,v_ma,'color',plt_color,'linewidth',3);
hold off
lgs=[lgs {sprintf('%s %d day MA',ticker,ma_days)}];

%%
legend(h,lgs)