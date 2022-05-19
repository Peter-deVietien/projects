cca

%%
series_key1='PET.WTTSTUS1.W';
series_key2='PET.WRPUPUS2.4';
series_key3='PET.RBRTE.W';

[dinit1,metadata1]=load_eia_series(series_key1);
d1=process_weekly_data(dinit1);

[dinit2,metadata2]=load_eia_series(series_key2);
d2=process_weekly_data(dinit2);

[dinit3,metadata3]=load_eia_series(series_key3);
d3=process_weekly_data(dinit3);


%% Clip to common times

firstdate=max(d1.dates(1),d2.dates(1));

ind1=find(d1.dates>=firstdate,1,'first');
ind2=find(d2.dates>=firstdate,1,'first');

d1.dates=d1.dates(ind1:end);
d1.y=d1.y(ind1:end);

d2.dates=d2.dates(ind2:end);
d2.y=d2.y(ind2:end);

[uv,ui]=unique(d1.dates);

k1=ismember(d1.dates,d2.dates);
k2=ismember(d2.dates,d1.dates);

d1.dates=d1.dates(k1);
d1.y=d1.y(k1);

%% Manual Add

eia_weekly_manual_data

d1.dates=[d1.dates; mandates];
d1.y=[d1.y; maninventories];

d2.dates=[d2.dates; mandates];
d2.y=[d2.y; mantotal_product_4wk];

d3.dates=[d3.dates; mandates];
d3.y=[d3.y; manbrent];

%%
days_remaining=d1.y./d2.y;

%%

scale=2;
fig=figure;
fig.Position=[75.8000 342 1200/scale 675/scale];

lacolor=[0 0.4470 0.7410];

p=plot(d1.dates,days_remaining,'linewidth',1,'color',lacolor);
p.Color(4)=0.8;

hold on
p=plot([d1.dates(1) d1.dates(end)],[1 1]*days_remaining(end),'color','b');
hold off
%%
grid on

ax=gca;
ax.FontSize=14;
ax.GridAlpha=0.3;


ylim([65 115])

ylabel('Days Remaining')

yt=ax.YTick;
yl=ylim;

%%

yyaxis right
ax.YAxis(1).Color=lacolor;

%%
dates=d3.dates;
brent=d3.y;

[~,infl]=inflation_vs_t(dates);

brent_infl=brent./infl;

%%
racolor=[0.8500 0.3250 0.0980 1];
ax.YAxis(2).Color=racolor;
ax.XGrid='off';

 
p=plot(dates,brent_infl,'color',racolor,'linewidth',1);
p.Color(4)=0.8;
xl=xlim;
xlim([datetime(1995,1,1) xl(2)+calmonths(6)]);
ax.YTick=[0:25:200];

ylabel('Brent [2022 USD]')

lgn=legend('Days Remaining','Today''s Days Remaining','Brent Crude','fontsize',11);
lgn.Position=[0.1442 0.6160 0.2725 0.1306];

tstr=sprintf('Days Remaining U.S. and Brent Inflation Adjusted\nIncludes May 18th Release');
tt=title(tstr);
tt.FontName='Arial Unicode MS';
tt.Position=[6.3999e+03 107.2958 -0.5000];

t1=text(0.01,0.03,'Days Remaining = Total Inventory incl. SPR / 4 Wk Average Total Product Consumed','fontsize',12,'units','normalized');
t2=text(0.42,-0.105,'Truth Social: @pdv  Twitter: @peterdevietien   Data: EIA','fontsize',11,'units','normalized');

%%
filename='days-remaining-usa-weekly-brent';
print(sprintf('~/projects/eia/post/%s',filename),'-dpng')