cca

%%
series_key1='STEO.PASC_OECD_T3.M';
series_key2='STEO.PATC_WORLD.M';
series_key3='PET.RBRTE.W';

[dinit1,metadata1]=load_eia_series(series_key1);
d1=process_monthly_data(dinit1);

[dinit2,metadata2]=load_eia_series(series_key2);
d2=process_monthly_data(dinit2);

[dinit3,metadata3]=load_eia_series(series_key3);
d3=process_weekly_data(dinit3);

%%
rightycolor=[0.8500 0.3250 0.0980];
leftycolor=[0 0.4470 0.7410];

%% Clip to common times

sind=find(d2.dates==d1.dates(1));
d2.dates=d2.dates(sind:end);
d2.y=d2.y(sind:end);

edate=datetime(2022,6,eomday(2022,6));

eind=find(d1.dates==edate);

d1.dates=d1.dates(1:eind);
d1.y=d1.y(1:eind);

d2.dates=d2.dates(1:eind);
d2.y=d2.y(1:eind);

%%
days_remaining=d1.y./d2.y;

%%

fig=figure;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

plot(d1.dates,days_remaining,'linewidth',2,'color',leftycolor)

hold on
plot([d1.dates(1) d1.dates(end)],[1 1]*days_remaining(end),'color',leftycolor)
hold off
%%

ylbl=ylabel('Days Remaining');
%ylbl.Position=[-50 31.5000 -1.0000];
yl=[25 38];
ylim(yl)

%%
yyaxis right

[~,infl]=inflation_vs_t(d3.dates);

p=plot(d3.dates,d3.y./infl,'linewidth',2,'color',rightycolor);
p.Color(4)=0.8;

hold on
p=plot([d3.dates(1) d3.dates(end)],[1 1]*d3.y(end)/infl(end),'linewidth',1,'color',rightycolor,'linestyle','-');
hold off
p.Color(4)=0.4;

ax=gca;
ax.YTick=[0:20:200];
ylabel('Brent [2022 USD]')

%%
grid on

ax=gca;
ax.FontSize=14;
ax.GridAlpha=0.08;

ax.YAxis(1).Color=leftycolor;
ax.YAxis(2).Color=rightycolor;


xlim([datetime(2004,1,1) datetime(2023,1,1)])

tstr=sprintf('Days Remaining & Infl. Adj. Brent\nOECD Inventory/Global Consumption');
tt=title(tstr);
%tt.Position=[4.1268e+03 35.8123 -0.5000];
%tt.FontSize=25;

tt.FontName='Arial Unicode MS';

text(0.01,0.025,'Last Data: June 2022 from July STEO','fontsize',11,'units','normalized')
text(0.37,-0.108,'Truth Social: @pdv  Twitter: @peterdevietien   Data: EIA, STEO','fontsize',11,'units','normalized')

%%
filename='days-remaining-oecd-global-brent';
print(sprintf('~/projects/eia/post/%s',filename),'-dpng')