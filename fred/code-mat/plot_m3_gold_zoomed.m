cca

[dm2,m2]=load_fred_series('MABMM301USM189S');
addpath('../../stock/code-mat')
[gdates,gprice]=load_gold_historical_prices_usd;

%%

ind=find(gdates>dm2(1),1,'first');

gprice=gprice/gprice(ind);

lw=1.5;

semilogy(dm2,m2/m2(1),'linewidth',lw);

hold on
semilogy(gdates,gprice,'linewidth',lw)
hold off

fig=gcf;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

ax=gca;
ax.FontSize=14;
ax.YGrid='on';
yticks=[0.1,0.2,0.5,1,2,4,8,16,24];
%ax.YTick=yticks;

y_lim=[.8 100];
ylim(y_lim);

yyaxis right

ax=gca;
%ax.YTick=yticks;
ax.YScale='log';
ylim(y_lim);
ax.YAxis(2).Color='k';
%%

lgn=legend('M3','Gold');
lgn.Position=[0.1475 0.7923 0.1142 0.1024];

title('U.S. M3 vs Gold')

%%
t1=text(0.714,0.100,['Last Date: ',datestr(gdates(end),'dd-mmm-yyyy')],'fontsize',12,'units','normalized');
t2=text(0.3011,0.0382,['Both curves shifted arbitrarily.  Focusing on relative growth'],'fontsize',12,'units','normalized');
t3=text(0.55,-0.11,'Twitter: @peterdevietien   Data: FRED','fontsize',12,'units','normalized');

%xl=xlim;
xlim([datetime(1955,1,1) datetime(2024,1,1)])

%%

print('~/projects/stock/post/m3_gold','-dpng')