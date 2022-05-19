cca

load_price_book_ratio

%%
fig=gcf;
fig.Position=[476 468 799 412];

plot(dates,pbrat,'linewidth',3)

ylabel('Price to Book Ratio')

%%
ax=gca;
ax.FontSize=18;

grid on

%%
xl=xlim;
xlim([xl(1) xl(2)+calyears(1)])
ylim([0 7])

title('Price to Book Ratio of S&P500','fontsize',20)

text(0.28,0.04,'https://www.multpl.com/s-p-500-price-to-book/table/by-year','fontsize',16,'units','normalized');

%%
print('~/projects/stock/post/price_book_ratio','-dpng')