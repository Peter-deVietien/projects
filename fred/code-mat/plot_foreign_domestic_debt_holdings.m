cca

series_key='FDHBFIN';
[fdates,foreign]=load_fred_series(series_key);

series_key='FYGFDPUN';
[ddates,domestic]=load_fred_series(series_key);

%%
fig=figure;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

plot(fdates,foreign/1000,'linewidth',3)
hold on
plot(fdates,domestic/1e6,'linewidth',3)
hold off

%%
grid on

ax=gca;
ax.FontSize=15;
ax.XGrid='off';
ax.YTick=[0:2:30];
ax.Position=[0.1300 0.1215 0.7750 0.8035];
ylim([0 30])

ylabel('Trillions USD')

yyaxis right

ax=gca;
ax.YTick=[0:2:30];
ylim([0 30])
ax.YAxis(2).Color='k';

lgn=legend('Foreign Holdings','Domestic Holdings','fontsize',16);
lgn.Position=[0.1475 0.7656 0.2950 0.1261];

title('Domestic and Foreign Holdings of U.S. Federal Debt')

xl=xlim;
xlim([xl(1) xl(2)+calmonths(3)])

%%
t1=text(0.7237,0.0383,['Last date: ',datestr(fdates(end))],'fontsize',12,'units','normalized');
t2=text(0.4849,-0.1198,'Twitter: @peterdevietien   Data: St. Louis Fed','fontsize',12,'units','normalized');

filename='foreign_domestic_debt_holdings';
print(sprintf('~/projects/fred/post/%s',filename),'-dpng')