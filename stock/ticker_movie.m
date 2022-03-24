cca;
ticker='^GSPC';

load_ticker_data

k=price==0;
price(k)=[];
dates_full(k)=[];

%%
window=7;
dt=30;
sdate=dates_full(1);
edate=dates_full(end);


plot(dates_full,price)
ax=gca;
ax.FontSize=15;
grid on
title('S&P 500 History')

curdate=sdate;

while (curdate+years(window))<edate
    xlim([curdate curdate+years(window)])
    ind=find(dates_full>(curdate+years(window)),1,'first');
    maxprice=max(price(1:ind));
    hold on
    h=plot([curdate curdate+years(window)],[1 1]*maxprice,'k--');
    hold off
    drawnow
    pause(0.05)
    curdate=curdate+days(dt);
    delete(h);
end