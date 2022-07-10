cca

d=load_ticker_data('DX-Y.NYB');

dates=d.dates_close;
price=d.close;


%%

lw=1.5;

plot(dates,price,'linewidth',lw);

hold on
plot([dates(1) dates(end)],[1 1]*price(end),'linewidth',0.5)
hold off

fig=gcf;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

ax=gca;
ax.FontSize=14;
ax.YGrid='on';
yticks=[60:20:180];
ax.YTick=yticks;

y_lim=[60 180];
ylim(y_lim);

yyaxis right

ax=gca;
ax.YTick=yticks;
ylim(y_lim);
ax.YAxis(2).Color='k';
%%

title(['DXY: USD Currency Basket'])

%%
t1=text(0.714,0.0382,['Last Date: ',datestr(dates(end),'dd-mmm-yyyy')],'fontsize',12,'units','normalized');
t2=text(-0.0177,-0.1085,'Twitter: @peterdevietien   Data: MacroTrends','fontsize',11,'units','normalized');

xlim([dates(1) dates(end)+calyears(1)])

%%

print('~/projects/stock/post/dxy','-dpng')