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

fig=gcf;
fig.Position=[46 330 990 536];

ylim([65 115])

%%

ylabel('Days Remaining')

yt=ax.YTick;
yl=ylim;



yyaxis right
ax.YAxis(1).Color=lacolor;


%%

t=readtable('~/projects/eia/data/CPIAUCSL.csv');

t.DATE(end+1)=t.DATE(end)+calmonths(1);
t.CPIAUCSL(end)=t.CPIAUCSL(end-1)/t.CPIAUCSL(end-2)*t.CPIAUCSL(end-1);

t.DATE(end+1)=t.DATE(end)+calmonths(1);
t.CPIAUCSL(end)=t.CPIAUCSL(end-1)/t.CPIAUCSL(end-2)*t.CPIAUCSL(end-1);

t.DATE(end+1)=t.DATE(end)+calmonths(1);
t.CPIAUCSL(end)=t.CPIAUCSL(end-1)/t.CPIAUCSL(end-2)*t.CPIAUCSL(end-1);

idate=t.DATE;
infl=t.CPIAUCSL/t.CPIAUCSL(end);

%%

%%
dates=d3.dates;
brent=d3.y;

%%
dates=[dates;datetime(2022,3,1)];
brent=[brent;110];

ddays=days(dates(1)-idate(1));
sdays=days(dates-dates(1));
sidays=days(idate-idate(1))-ddays;

sinfl=spline(sidays,infl,sdays);

brent_infl=brent./sinfl;

%brent=moving_average(dates,brent,20);
%brent_infl=moving_average(dates,brent_infl,20);

%%
racolor=[0.8500 0.3250 0.0980 1];
ax.YAxis(2).Color=racolor;
 
p=plot(dates,brent_infl,'color',racolor,'linewidth',3);
p.Color(4)=0.5;
xl=xlim;
xlim([datetime(1995,1,1) xl(2)+calmonths(6)]);

%xlim([datetime(2006,1,1)  datetime(2010,1,1)])

ylabel('Brent [2022 USD]')

lgn=legend('Days Remaining','Today''s Days Remaining','Brent Crude','fontsize',18);
lgn.Position=[0.1295 0.7342 0.2434 0.1321];

tstr=sprintf('Days Remaining U.S. and Brent Inflation Adjusted\nIncludes March 30th Release');%s',datestr(d2.dates(end),'yyyy mmm dd'));
tt=title(tstr);
%tt.Position(2)=125;
%tt.Position(1)=3.300e+03;
tt.FontSize=24;

tt.FontName='Arial Unicode MS';%fname;

text(0.42,0.02,'Total Inventory incl. SPR / 4 Wk Average Total Product Consumed','fontsize',15,'units','normalized')
%text(0.62,-0.105,'Twitter: @peterdevietien   Data: EIA','fontsize',17,'units','normalized')
text(0.42,-0.105,'Truth Social: @pdv  Twitter: @peterdevietien   Data: EIA','fontsize',17,'units','normalized')

%%
filename='days-remaining-usa-weekly-brent';
print(sprintf('~/projects/eia/post/%s',filename),'-dpng')