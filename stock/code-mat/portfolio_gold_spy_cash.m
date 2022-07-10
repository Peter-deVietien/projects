cca

[gdates,gprice]=load_gold_historical_prices_usd;

[sdates,sprice,sprice_div]=load_sp500_historical_prices;

%%
% p = portfolio balance as of jan 1st of year after rebalancing
% p(1,:)=gold, p(2,:)=spy, p(3,:)=USD, p(4,:)=total

i=1;
p=nan(2021-1960,4);
p(1,1)=100/3;
p(1,2)=100/3;
p(1,3)=100/3;
p(1,4)=sum(p(1,1:3));
pdates=NaT(2021-1960,1);
pdates(1)=datetime(1960,1,1);

for y=1960:2021
    pdates(i+1)=datetime(y,1,1);
    gsind=find(gdates>=datetime(y,1,1),1,'first');
    geind=find(gdates>=datetime(y+1,1,1),1,'first')-1;
    
    ssind=find(sdates>=datetime(y,1,1),1,'first');
    seind=find(sdates>=datetime(y+1,1,1),1,'first')-1;

    gold_yoy=gprice(geind)/gprice(gsind);
    spy_yoy=sprice_div(seind)/sprice_div(ssind);
    
    yegold=p(i,1)*gold_yoy;
    yespy=p(i,1)*spy_yoy;
    
    yetotal=yegold+yespy+p(i,3);
    
    p(i+1,4)=yetotal;
    
    
    p(i+1,1)=yetotal/3;
    p(i+1,2)=yetotal/3;
    p(i+1,3)=yetotal/3;
    
    
    
    i=i+1;
end


lw=1.5;


plot(pdates,p(:,4),'linewidth',lw);

sind=find(sdates>pdates(1),1,'first');

sprice_div=sprice_div/sprice_div(sind)*100;

hold on
plot(sdates,sprice_div,'linewidth',lw)
hold off

fig=gcf;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

ax=gca;
ax.FontSize=14;
ax.YGrid='on';
yticks=[20,35,100,200,500,1000,2000];
ax.YTick=yticks;

y_lim=[19 4000];
ylim(y_lim);

yyaxis right

ax=gca;
ax.YTick=yticks;
ax.YScale='log';
ylim(y_lim);
ax.YAxis(2).Color='k';
%%

lgn=legend('Nominal Gold/USD','Real CPI Gold/USD');
lgn.Position=[0.6433 0.3627 0.2517 0.1024];

title('Real and Nominal Gold Price in USD')

%%
t1=text(0.714,0.0382,['Last Date: ',datestr(dates(end),'dd-mmm-yyyy')],'fontsize',12,'units','normalized');
t2=text(0.55,-0.11,'Twitter: @peterdevietien   Data: FRED','fontsize',12,'units','normalized');

xlim([dates(1) dates(end)+calyears(1)])

%%

print('~/projects/stock/post/portfolio_gold_spy_cash','-dpng')