cca

%%
[dates,price_no_div,price_div]=load_sp500_historical_prices();
[gdates,gprice]=load_gold_historical_prices_usd;

%% get common dates

[~,cprice]=dspline(gdates,gprice,dates);

fname_extension='';
title_extension='';

no_divs=price_no_div./cprice;
divs=price_div./cprice;

normalized=false;

if normalized
    no_divs=no_divs/no_divs(1);
    divs=divs/divs(1);
    fname_extension='_norm';
    title_extension=' (normed to 1 in 1930)';
end

%%
leftycolor=[0 0.4470 0.7410];
rightycolor=[0.8500 0.3250 0.0980];

fig=figure;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];


p(1)=plot(dates,no_divs,'linewidth',1,'color',leftycolor);

hold on
p(2)=plot(dates,divs,'linewidth',1,'color',rightycolor);
hold off

%%
grid on
ax=gca;
ax.FontSize=15;

title(['S&P 500 in Ounces of Gold',newline,'With/out Dividend Reinvestment',title_extension],'Fontsize',18)

ax.XGrid='off';
%ax.YTickLabel={'$1','$10','$100','$1,000','$10,000','$100,000','$1,000,0000'};


xlim([datetime(1930,1,1) datetime(2024,1,1)])


lgn=legend(p,'Without Dividends','Dividends Reinvested');
lgn.Position=[0.1400 0.7270 0.2867 0.1083];

t1=text(0.3223,-0.1161,'Truth Social: @pdv   Twitter: @peterdevietien    Data: Bloomberg','fontsize',11,'units','normalized');

%%
fname=sprintf('sp500_divs_vs_gold%s',fname_extension);
print(sprintf('~/projects/stock/post/%s',fname),'-dpng')