cca
ticker='^GSPC';


d=load_ticker_data(ticker);

price=d.price;
dates_full=d.dates_full;

sel=price==0;

price(sel)=[];
dates_full(sel)=[];

semilogy(dates_full,price,'b')

ma20y=moving_average(dates_full,price,365*20);
ma8y=moving_average(dates_full,price,365*8);
ma2y=moving_average(dates_full,price,365*3);



hold on
semilogy(dates_full,ma2y,'m')
semilogy(dates_full,ma8y,'k')
%semilogy(dates_full,ma20y,'k')
hold off

%%
nd=numel(dates_full);
fd=[];
for i=1:nd-1
    if sign(ma8y(i)-ma2y(i)) ~= sign(ma8y(i+1)-ma2y(i+1))
        fd=[fd i];
    end
end

nfd=numel(fd);
hold on
for i=1:nfd
    plot([dates_full(fd(i)) dates_full(fd(i))],[0.1 5000],'k--')
end
hold off

%%
grid on

title('S&P 500 History')

legend('S&P 500','2 Year Simple Moving Average','8 Year Simple Moving Average','autoupdate','off')

ax=gca;
ax.FontSize=18;

fig=gcf;
fig.Position=[23 367 1500 500];
ylim([5 4500])
xlim([datetime(1926,1,1) datetime(2022,1,1)])