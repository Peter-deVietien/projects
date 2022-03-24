cca

%%
series_key1='PET.RBRTE.D';

%%
[dinit1,metadata1]=load_eia_series(series_key1);
d1=process_weekly_data(dinit1);

%%
color1=[0 0.4470 0.7410];
color2=[0.8500 0.3250 0.0980];

%%
dates=d1.dates;
brent=d1.y;

%% Manual add

dates=[dates; datetime(date)];
brent=[brent; 110];
d1.y=[d1.y; 110];

%%

t=readtable('../data/CPIAUCSL.csv');

t.DATE(end+1)=t.DATE(end)+calmonths(1);
t.CPIAUCSL(end)=t.CPIAUCSL(end-1)/t.CPIAUCSL(end-2)*t.CPIAUCSL(end-1);

t.DATE(end+1)=t.DATE(end)+calmonths(1);
t.CPIAUCSL(end)=t.CPIAUCSL(end-1)/t.CPIAUCSL(end-2)*t.CPIAUCSL(end-1);

t.DATE(end+1)=t.DATE(end)+calmonths(1);
t.CPIAUCSL(end)=t.CPIAUCSL(end-1)/t.CPIAUCSL(end-2)*t.CPIAUCSL(end-1);

idate=t.DATE;
infl=t.CPIAUCSL/t.CPIAUCSL(end);



%%
ddays=days(dates(1)-idate(1));
sdays=days(dates-dates(1));
sidays=days(idate-idate(1))-ddays;

sinfl=spline(sidays,infl,sdays);

brent_infl=brent./sinfl;

brent=moving_average(dates,brent,20);
brent_infl=moving_average(dates,brent_infl,20);

brent(end)=d1.y(end);
brent_infl(end)=brent(end);
%%
plot(dates,brent,'linewidth',2,'color',[color1 0.3])

hold on
plot(dates,brent_infl,'linewidth',2,'color',color2)
hold off

ax=gca;
yticks=ax.YTick;
y_lim=ylim;

yyaxis right
ax=gca;
ax.YTick=yticks;
ylim(y_lim)
ax.YAxis(2).Color='k';



ax.FontSize=19;

grid on


fig=gcf;
fig.Position=[73 262 1368 544];

x_lim=xlim;

xlim([x_lim(1) x_lim(2)+calmonths(3)])


ylabel(sprintf('Brent Price [USD]'))

tt=title(sprintf('Brent Crude Price \nWith and Without Inflation \n[Dec 2021 USD]'),'fontsize',25);
tt.Position=[3.7737e+03 110.6648 -0.5000];
tt.FontSize=30;
tt.FontName='Arial Unicode MS';


lgn=legend('Brent','Brent with Inflation','fontsize',18);
lgn.Position=[0.2741 0.4715 0.1681 0.0873];

%%
text(datetime(2013,1,1),-16,'@peterdevietien  Data: EIA, St. Louis Fed','fontsize',16)

%%
print('~/projects/eia/post/brent_inflation','-dpng')
