cca

ticker='^GSPC';

d=load_ticker_data(ticker);

semilogy(d.dates_full,d.price/d.price(1))

grid on
ylim([1 250])

figure
logp=log10(d.price/d.price(1));

hold on
plot(d.dates_full,logp)
hold off

grid on
ylim([0 2.50])