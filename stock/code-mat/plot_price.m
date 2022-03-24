
%% Choose color if wanted
ax=gca;
if ~exist('plt_color','var')
    plt_color=ax.ColorOrder(ax.ColorOrderIndex,:);
end

%%
d=load_ticker_data(ticker);

%%
lgs=[];
h=plot(d.dates_full,d.price,'color',plt_color);
lgs=[lgs {sprintf('%s Price',ticker)}];

%%
legend(h,lgs)

ax.FontSize=20;

ylabel('Stock Price')