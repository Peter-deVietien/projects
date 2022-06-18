cca

%%
series_key1='STEO.PASC_OECD_T3.M';
series_key2='STEO.PATC_WORLD.M';

[dinit1,metadata1]=load_eia_series(series_key1);
con=process_monthly_data(dinit1);

[dinit2,metadata2]=load_eia_series(series_key2);
inv=process_monthly_data(dinit2);

%% Clip to common times

sdate=max(con.dates(1),inv.dates(1));
edate=datetime(2022,5,31);


ind1=find(con.dates==sdate);
ind2=find(inv.dates==sdate);

con.dates=con.dates(ind1:end);
con.y=con.y(ind1:end);

inv.dates=inv.dates(ind2:end);
inv.y=inv.y(ind2:end);

eind=find(con.dates==edate);
con.dates=con.dates(1:eind);
inv.dates=inv.dates(1:eind);
con.y=con.y(1:eind);
inv.y=inv.y(1:eind);

%%
days_remaining=con.y./inv.y;

%%

fig=figure;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

plot(con.dates,days_remaining,'linewidth',2)

hold on
plot([con.dates(1) con.dates(end)],[1 1]*days_remaining(end),'r')
hold off

%%
grid on

ax=gca;
ax.FontSize=14;
ax.GridAlpha=0.08;

%%

ylbl=ylabel('Days Remaining');
%ylbl.Position=[-50 31.5000 -1.0000];
yl=[25 38];
ylim(yl)
yt=ax.YTick;

yyaxis right

ylim(yl);
ax.YTick=yt;
ax.YAxis(2).Color='k';

xlim([datetime(2004,1,1) datetime(2023,1,1)])


tstr=sprintf('Days Remaining\nOECD Inventory/Global Consumption\nJune STEO:  May Last Data on Plot');
tt=title(tstr,'horizontalalignment','center','units','normalized');
tt.Position(2)=0.7745;
tt.Position(1)=0.5;
%tt.FontSize=25;

tt.FontName='Arial Unicode MS';


t1=text(0.6355,-0.1073,'Twitter: @peterdevietien   Data: EIA','fontsize',11,'units','normalized');

%%
filename='days-remaining-oecd-global';
print(sprintf('~/projects/eia/post/%s',filename),'-dpng')