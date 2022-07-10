cca

dxy=load_ticker_data('DX-Y.NYB');

ddates=dxy.dates_close;
dprice=dxy.close;

cny=load_ticker_data('CNY=X');

cdates=cny.dates_close;
cprice=cny.close;

%%

leftycolor=[0 0.4470 0.7410];
rightycolor=[0.8500 0.3250 0.0980];

fig=gcf;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

lw=1;

p(1)=plot(ddates,dprice,'linewidth',lw,'color',leftycolor);

hold on
plot([ddates(1) ddates(end)],[1 1]*dprice(end),'linewidth',0.5,'color',leftycolor)
hold off


ax=gca;
ax.FontSize=14;
ax.YGrid='on';
yticks=[60:20:180];
ax.YTick=yticks;

y_lim=[60 180];
ylim(y_lim);

yyaxis right


p(2)=plot(cdates,cprice,'linewidth',lw,'color',rightycolor);


hold on
plot([cdates(end) cdates(end)+calyears(10)],[1 1]*cprice(end),'linewidth',0.5,'linestyle','-','color',rightycolor)
hold off


ax=gca;
%ax.YTick=yticks;
%ylim(y_lim);
ax.YAxis(2).Color='k';
%%

title(['DXY and USD/CNY'])

lgn=legend(p,'DXY','USD/CNY');

%%
t1=text(0.714,0.0382,['Last Date: ',datestr(ddates(end),'dd-mmm-yyyy')],'fontsize',12,'units','normalized');
t2=text(-0.0177,-0.1085,'Twitter: @peterdevietien','fontsize',11,'units','normalized');

xlim([datetime(2000,1,1) ddates(end)+calmonths(6)])

%%

print('~/projects/stock/post/dxy_cny_zoomed','-dpng')