cca

[dates,deficit]=load_fred_series('MTSDS133FMS');

%%
fig=gcf;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

lw=1.5;

plot(dates,deficit/1e3,'linewidth',lw);


ax=gca;
ax.FontSize=14;
ax.YGrid='on';
yticks=[-1000:200:400];
ax.YTick=yticks;

y_lim=[-1000 400];
ylim(y_lim);

ylabel('Monthly Federal Deficit [USD Billions]')

yyaxis right

ax=gca;
ax.YTick=yticks;
ylim(y_lim);
ax.YAxis(2).Color='k';

%%

title(['U.S. Federal Deficit, Monthly'])

%%
t1=text(0.714,0.0382,['Last Date: ',datestr(dates(end),'dd-mmm-yyyy')],'fontsize',12,'units','normalized');
t3=text(0.55,-0.11,'Twitter: @peterdevietien   Data: FRED','fontsize',12,'units','normalized');

%xl=xlim;
xlim([datetime(1980,1,1) datetime(2024,1,1)])

%%

print('~/projects/stock/post/federal_deficit','-dpng')