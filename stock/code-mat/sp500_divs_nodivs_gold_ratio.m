cca

%%
[dates,price_no_div,price_div]=load_sp500_historical_prices();
[gdates,gprice]=load_gold_historical_prices_usd;

%% get common dates

[~,cprice]=dspline(gdates,gprice,dates);

%%
leftycolor=[0 0.4470 0.7410];
rightycolor=[0.8500 0.3250 0.0980];

fig=figure;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];


p(1)=plot(dates,price_no_div./cprice,'linewidth',1,'color',leftycolor);

hold on
p(2)=plot(dates,price_div./cprice,'linewidth',1,'color',rightycolor);
hold off

%%
grid on
ax=gca;
ax.FontSize=15;

title(['S&P 500 in ounces of Gold',newline,'With and Without Dividend Reinvestment'],'Fontsize',18)

ax.XGrid='off';
%ax.YTickLabel={'$1','$10','$100','$1,000','$10,000','$100,000','$1,000,0000'};


xlim([datetime(1930,1,1) datetime(2024,1,1)])


lgn=legend(p,'Without Dividends','Dividends Reinvested');
lgn.Position=[0.1400 0.7270 0.2867 0.1083];

t1=text(0.3223,-0.1161,'Truth Social: @pdv   Twitter: @peterdevietien    Data: Bloomberg','fontsize',11,'units','normalized');

%%
print('~/projects/stock/post/sp500_divs_vs_gold','-dpng')