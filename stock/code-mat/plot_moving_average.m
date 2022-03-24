cca

ticker='OXY';

load_ticker_data

MA_days=[3*365];


%%
h(1)=plot(dates_full,price,'k','linewidth',2);
text(dates_full(end)+10,price(end),num2str(round(price(end),0)),'fontsize',20)

%% txd low
avg_price=mean([open,low,high,close],2);
lgs=[{sprintf('%s Price',ticker)}];

for i=1:numel(MA_days)
    v_MA=moving_average(avg_price,MA_days);
    hold on
    h(i+1)=plot(dates,v_MA,'linewidth',3);
    hold off
    lgs=[lgs,{sprintf('%s %d day MA',ticker,MA_days(i))}];
    text(dates(end)+10,v_MA(end),num2str(round(v_MA(end),0)),'fontsize',20)

end

%% Adornments

grid on
t_str=sprintf('%s Stock Price Moving Averages',ticker);
title(t_str,'fontsize',20)
ylabel('Stock Price')

ax=gca;
ax.FontSize=26;

f=gcf;
f.Position=[-1744 314 1688 464];

lgh=legend(h,lgs,'location','best','autoupdate','off');

%%
save_name=sprintf('%s_moving_average.png',ticker);
print(save_name,'-dpng')