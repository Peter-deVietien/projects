cca

[gdates,gprice]=load_gold_historical_prices_usd;

%%

lw=1;

depreciation=1./gprice;
depreciation=depreciation/depreciation(1);

semilogy(gdates,depreciation,'linewidth',lw);

fig=gcf;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

ax=gca;
ax.FontSize=14;
ax.YGrid='on';
yticks=[0.01,0.03,0.1,0.3,1];
ylbl={'1/100','1/30','1/10','1/3','1'};
ax.YTick=yticks;
ax.YTickLabel=ylbl;

y_lim=[0.006 2];
ylim(y_lim);

yyaxis right

ax=gca;
ax.YTick=yticks;
ax.YTickLabel=ylbl;

ax.YScale='log';
ylim(y_lim);
ax.YAxis(2).Color='k';
%%

title('USD Depreciation vs Gold')

%%
t1=text(0.0151,0.0382,['Last Date: ',datestr(gdates(end),'dd-mmm-yyyy')],'fontsize',12,'units','normalized');
t2=text(0.0145,-0.1136,'Twitter: @peterdevietien','fontsize',12,'units','normalized');

xlim([gdates(1) gdates(end)+calyears(5)])

%%

print('~/projects/stock/post/usd_depreciation_gold','-dpng')