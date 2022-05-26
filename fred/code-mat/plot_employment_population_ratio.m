cca

series_key='EMRATIO';
[dates,emratio]=load_fred_series(series_key);

%%
fig=figure;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

plot(dates,emratio,'linewidth',2)

%%
grid on

ax=gca;
ax.FontSize=15;
ax.XGrid='off';
ax.YTick=[50:2:66];
ax.Position=[0.1300 0.1215 0.7750 0.8035];

ylabel('Percent')

title('Percent of Population Employed')

xl=xlim;
xlim([xl(1) xl(2)+calmonths(3)])

%%
t1=text(0.0097,0.0346,['Last date: ',datestr(dates(end))],'fontsize',12,'units','normalized');
t2=text(-0.014,-0.1198,'Twitter: @peterdevietien   Data: St. Louis Fed','fontsize',12,'units','normalized');

filename='employment_population_ratio';
print(sprintf('~/projects/fred/post/%s',filename),'-dpng')