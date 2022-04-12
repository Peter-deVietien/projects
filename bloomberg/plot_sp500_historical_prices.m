cca

[dates,price_no_div,price_div]=load_sp500_historical_prices;

%%

semilogy(dates,price_no_div/price_no_div(1))

hold on
semilogy(dates,price_div/price_div(1))
hold off

xl=xlim;
xlim([xl(1) xl(2)+calyears(1)])

t1=text(xl(2)+calyears(2),price_div(end)/price_div(1),['$',num2cstr(floor(price_div(end)/price_div(1)))],'fontsize',16);
t2=text(xl(2)+calyears(2),price_no_div(end)/price_no_div(1),['$',num2cstr(floor(price_no_div(end)/price_no_div(1)))],'fontsize',16);

%%
grid on
ax=gca;
ax.FontSize=15;
ax.XGrid='off';
ax.YTickLabel={'$0.10','$1.00','$10','$100','$1,000','$10,000'};


fig=gcf;
fig.Position=[279.8000 194.2000 887.2000 497.2000];

lgn=legend('No Dividend Reinvestment','Dividend Reinvestment');
lgn.Position=[0.1303 0.7773 0.2978 0.0992];

title(['Total Return S&P500',newline,'With and Without Dividend Reinvestment'])