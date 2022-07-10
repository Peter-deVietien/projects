cca

[dates,price]=load_gold_historical_prices_usd;

%%

fig=gcf;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];
yparray=[];

mdates=[];
mprice=[];

for y=1834:2022
    sel=year(dates)==y;
    ydates=dates(sel);
    yprice=price(sel);
    for m=1:12
        msel=month(ydates)==m;
        mprice=[mprice;mean(yprice(msel))];
        mdates=[mdates;datetime(y,m,15)];
    end
end

%%
sel=isnan(mprice);
mdates(sel)=[];
mprice(sel)=[];

%%
mom=mprice(2:end)./mprice(1:end-1);
mdates=mdates(2:end)

for m=1:12

    sel=month(mdates)==m;

    histogram((mom(sel)-1)*100,100)
    xlim([-15 15])
    ylim([0 10])
    
    title(['Gold MoM change Month: ',num2str(m),newline,'Average: ',num2str(mean(mom(sel)))])
end

figure
mavg=[];
momavg=[];
for m=1:12
    sel=month(mdates)==m;
    mavg=[mavg; m];
    momavg=[momavg;(mean(mom(sel))-1)*100];
end

bar(mavg,momavg)


    hold on
    p=plot(ydates,yprice,'k-');
    p.Color(4)=0.5;
    hold off

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

print('~/projects/stock/post/gold_yearly','-dpng')