cca

%%
series_key1='PET.WTTSTUS1.M';

series_key1='STEO.PASC_OECD_T3.M';
series_key2='STEO.PATC_WORLD.M';

series_key3='PET.RBRTE.W';

[dinit1,metadata1]=load_eia_series(series_key1);
d1=process_weekly_data(dinit1);

[dinit2,metadata2]=load_eia_series(series_key2);
d2=process_weekly_data(dinit2);

[dinit3,metadata3]=load_eia_series(series_key3);
d3=process_weekly_data(dinit3);



%%
days_remaining=d1.y./d2.y;

%%
scale=2;
fig=figure;
fig.Position=[75.8000 342 1200/scale 675/scale];

lacolor=[0 0.4470 0.7410];

p=plot(d1.dates,days_remaining,'linewidth',3,'color',lacolor);
p.Color(4)=0.5;

hold on
p=plot([d1.dates(1) d1.dates(end)],[1 1]*days_remaining(end),'color','b');
hold off
%%
grid on

ax=gca;
ax.FontSize=18;
ax.GridAlpha=0.3;

ylim([65 115])

%%

ylabel('Days Remaining')

yt=ax.YTick;
yl=ylim;

yyaxis right

ax=gca;
ax.YAxis(1).Color=lacolor;

%%
dates=d3.dates;
brent=d3.y;

[~,infl]=inflation_vs_t(dates);

brent_infl=brent./infl;

%%
ax=gca;
racolor=[0.8500 0.3250 0.0980 1];
ax.YAxis(2).Color=racolor;
ax.XGrid='off';
 
p=plot(dates,brent_infl,'color',racolor,'linewidth',3);
p.Color(4)=0.5;

ax.YTick=[0:25:200];

xl=xlim;
xlim([datetime(1995,1,1) xl(2)+calmonths(6)]);

ylabel('Brent [2022 USD]')

lgn=legend('Days Remaining','Today''s Days Remaining','Brent Crude','fontsize',14);
lgn.Position=[0.1335 0.7360 0.3509 0.1617];

releasestr='May 4th';
tstr=sprintf('U.S. Days Remaining and Brent in 2022 USD');
tt=title(tstr);

tt.FontName='Arial Unicode MS';

releasedate='May 4th';
t1=text(0.322,0.075,sprintf('Includes %s EIA Release',releasedate),'fontsize',13,'units','normalized');
t2=text(0.081,0.024,'Total Inventory incl. SPR / 4 Wk Average Total Product Consumed','fontsize',13,'units','normalized');
t3=text(0.305,-0.1125,'Truth Social: @pdv  Twitter: @peterdevietien   Data: EIA','fontsize',13,'units','normalized');

%%
filename='days-remaining-usa-weekly-brent-post';
print(sprintf('~/projects/eia/post/%s',filename),'-dpng')