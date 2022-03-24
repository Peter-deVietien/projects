clear
close all

ticker1='DIA';
d1=load_ticker_data(ticker1);

ticker2='SPY';
d2=load_ticker_data(ticker2);

%%
normalized=0;

if normalized
   
   [start_date,istart]=max([d1.dates_full(1),d2.dates_full(1)]);
   i1=find(d1.dates_full==start_date);
   i2=find(d2.dates_full==start_date);
   
   d1.price=d1.price/d1.price(i1);
   d2.price=d2.price/d2.price(i2);
end

semilogy(d1.dates_full,d1.price)

hold on
semilogy(d2.dates_full,d2.price)
hold off

%%
%xlim([start_date datetime])

grid on
lgn=legend(ticker1,ticker2);
lgn.FontSize=15;
