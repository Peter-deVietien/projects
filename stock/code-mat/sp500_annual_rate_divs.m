cca

%%
[dates,price_no_div,price_div]=load_sp500_historical_prices();

%%
lp=log(price_no_div);
lpd=log(price_div);

dls=days(dates-dates(1));
[yo,mo,x,bo]=least_squares(dls,lp);
[yod,mod,xd,bod]=least_squares(dls,lpd);

%%
leftycolor=[0 0.4470 0.7410];
rightycolor=[0.8500 0.3250 0.0980];

p(1)=semilogy(dates,price_no_div,'linewidth',2,'color',leftycolor);

hold on
p(2)=semilogy(dates,price_div,'linewidth',2,'color',rightycolor);
semilogy(dates,exp(yo),'color',leftycolor)
semilogy(dates,exp(yod),'color',rightycolor)
hold off

%%


%%
grid on
ax=gca;
ax.FontSize=18;

title(['S&P 500 With and Without',newline,'Dividend Reinvestment'],'Fontsize',28)

ax.XGrid='off';
ax.YTickLabel={'$1','$10','$100','$1,000','$10,000','$100,000','$1,000,0000'};

fig=gcf;
fig.Position=[168 294 868 572];

xlim([datetime(1930,1,1) datetime(2024,1,1)])

annual_rate=365*(exp(mo)-1);
annual_rated=365*(exp(mod)-1);

lgn=legend(p,sprintf('Without Dividends:      %.1f%% Annually',annual_rate*100),sprintf('Dividend Reinvested: %.1f%% Annually',annual_rated*100),'fontsize',22);
lgn.Position=[0.1432 0.7552 0.4724 0.0988];

t1=text(0.3223,-0.1161,'Truth Social: @pdv   Twitter: @peterdevietien    Data: Bloomberg','fontsize',16,'units','normalized');

%%
print('~/projects/stock/post/sp500_annual_rate_divs','-dpng')