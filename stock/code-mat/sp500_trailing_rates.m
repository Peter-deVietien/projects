cca
ticker='^GSPC';


d=load_ticker_data(ticker);

price=d.price;
dates=d.dates_full;

sel=price==0;

price(sel)=[];
dates(sel)=[];


%%
lnp=log(price(end)/price(1));
dx=years(dates(end)-dates(1));

i=exp(lnp/dx)-1;


nx=years(dates(end)-dates(1));
xinterp=dates(1)+[1:nx];

%yinterp=price(1)*(1+i).^([1:nx]/365);
yinterp=log(price(1))+i*[1:nx];
%%

lp=log(price);

plot(dates,lp,'b')

hold on
plot(xinterp,yinterp)
hold off

%%
grid on

title('S&P 500 History')

%legend('S&P 500','autoupdate','off')

ax=gca;
ax.FontSize=18;

fig=gcf;
fig.Position=[23 367 1500 500];
%ylim([5 5000])
%xlim([datetime(1948,1,1) datetime(2023,1,1)])