cca

[gdates,gprice]=load_gold_historical_prices_usd;
[sdates,sprice]=load_silver_historical_prices_usd;


%%
[spdates,spgp]=dspline(gdates,gprice,sdates);

%%

goldcolor=[0.9290 0.6940 0.1250];
silvercolor=[0.3010 0.7450 0.9330];

fig=gcf;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

lw=1.5;

p(1)=semilogy(spdates,spgp,'linewidth',lw,'color',goldcolor);

hold on
plot([spdates(1) spdates(end)],[1 1]*spgp(end),'linewidth',0.5,'color',goldcolor)
hold off


ax=gca;
ax.FontSize=14;
ax.YGrid='on';
yticks=[300,300*2,300*4,300*8];
ax.YTick=yticks;

y_lim=[250 2500];
ylim(y_lim);


yyaxis right

p(2)=semilogy([sdates(1:2:end-5000);sdates(end-5000:10:end)],[sprice(1:2:end-5000);sprice(end-5000:10:end)],'linewidth',lw,'color',silvercolor);
p(2).Color(4)=0.5;

hold on
plot([sdates(1) sdates(end)],[1 1]*sprice(end),'linewidth',0.5,'linestyle','-','color',silvercolor)
hold off




ax=gca;
ax.YTick=[4,4*2,4*2^2,4*2^3];
ylim([1 y_lim(2)/y_lim(1)]*4);
ax.YAxis(2).Color='k';
%%

title(['Silver has lagged gold the last century'])

lgn=legend(p,'Gold USD/oz','Silver USD/oz');
lgn.Position=[0.1475 0.6234 0.1992 0.1024];

%%
t1=text(0.714,0.0382,['Last Date: ',datestr(spdates(end),'dd-mmm-yyyy')],'fontsize',12,'units','normalized');
t2=text(-0.0177,-0.1085,'Twitter: @peterdevietien   Data: MacroTrends','fontsize',11,'units','normalized');

x_lim=[datetime(2000,1,1) datetime(2023,1,1)];
xlim(x_lim)

%%

print('~/projects/stock/post/gold_silver_vs_usd_zoomed','-dpng')