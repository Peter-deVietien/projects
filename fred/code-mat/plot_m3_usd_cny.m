cca

[dcny,m3cny]=load_fred_series('MABMM301CNM189S');
[dusd,m3usd]=load_fred_series('MABMM301USM189S');

%%

lw=2;

semilogy(dusd,m3usd/1e12,'linewidth',lw);

hold on
semilogy(dcny,m3cny/1e12,'linewidth',lw);
hold off

fig=gcf;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

ax=gca;
ax.FontSize=14;
ax.YGrid='on';
yticks=[.3 1 3 10 30 100 300];
ax.YTick=yticks;

y_lim=[0.2 400];
ylim(y_lim);

yyaxis right

ax=gca;
ax.YTick=yticks;
ax.YScale='log';
ylim(y_lim);
ax.YAxis(2).Color='k';
%%

lgn=legend('USA M3','China M3');
lgn.Position=[0.1492 0.6590 0.1592 0.1024];

title('U.S. and Chinese Monetary Aggregates')

%%
%t1=text(0.714,0.0382,['Last Date: ',datestr(dates(end),'dd-mmm-yyyy')],'fontsize',12,'units','normalized');
t2=text(0.55,-0.11,'Twitter: @peterdevietien   Data: FRED','fontsize',12,'units','normalized');

xl=xlim;
xlim([xl(1) xl(end)+calyears(1)])

%%

print('~/projects/stock/post/m3_usd_cny','-dpng')