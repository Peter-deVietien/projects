cca

[dates,onepct]=load_fred_series('WFRBST01134');
zi = load_zucman_inequality;

%%

lw=3;

plot(dates,onepct,'linewidth',lw);

hold on
plot(zi.dates,zi.top1pct*100,'linewidth',lw)
hold off

fig=gcf;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

ax=gca;
ax.FontSize=14;
ax.YGrid='on';
yticks=[0:10:100];
ax.YTick=yticks;

y_lim=[0 100];
ylim(y_lim);

yyaxis right

ax=gca;
ax.YTick=yticks;
%ax.YScale='log';
ylim(y_lim);
ax.YAxis(2).Color='k';
%%

title('Share of Total Net Worth Held by Top 1%')

lgn = legend('Federal Reserve','Saez and Zucman, 2016');
%%
%t1=text(0.714,0.0382,['Last Date: ',datestr(dates(end),'dd-mmm-yyyy')],'fontsize',12,'units','normalized');
t2=text(0.7328,-0.11,'Twitter: @peterdevietien','fontsize',12,'units','normalized');

xl=xlim;
xlim([datetime(1910,1,1) datetime(2023,1,1)])

%%

print('~/projects/stock/post/top_1pct_usa','-dpng')