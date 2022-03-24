cca

%%
series_key1='PET.WTTSTUS1.W';
series_key2='PET.WRPUPUS2.4';

[dinit1,metadata1]=load_eia_series(series_key1);
d1=process_weekly_data(dinit1);

[dinit2,metadata2]=load_eia_series(series_key2);
d2=process_weekly_data(dinit2);

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

d1.dates=[d1.dates; datetime(2022,3,18)];
d1.y=[d1.y; 1.7081e6];

d2.dates=[d2.dates; datetime(2022,3,18)];
d2.y=[d2.y; 20954];

%%
days_remaining=d1.y./d2.y;

%%

plot(d1.dates,days_remaining,'linewidth',2)

hold on
plot([d1.dates(1) d1.dates(end)],[1 1]*days_remaining(end),'r')
hold off

%%
grid on

ax=gca;
ax.FontSize=18;
ax.GridAlpha=0.08;

fig=gcf;
fig.Position=[144 341 892 525];

yl=[65 110];
ylim(yl)

%%

ylabel('Days Remaining')

yt=ax.YTick;

yyaxis right

ylim(yl);
ax.YTick=yt;
ax.YAxis(2).Color='k';
    
xl=xlim;
xlim([xl(1) xl(2)+calmonths(3)]);

%xlim([datetime(2006,1,1)  datetime(2010,1,1)])

lgn=legend('Days Remaining','Today''s Value','fontsize',18);
lgn.Position=[0.1530 0.7514 0.1928 0.0905];

tstr=sprintf('Days Remaining of U.S. Total Product\nIncludes March 23rd Release');%s',datestr(d2.dates(end),'yyyy mmm dd'));
tt=title(tstr);
%tt.Position(2)=125;
%tt.Position(1)=3.300e+03;
tt.FontSize=24;

tt.FontName='Arial Unicode MS';%fname;

text(0.34,0.02,'Total Inventory incl. SPR / 4 Wk Average Total Product Consumed','fontsize',15,'units','normalized')

text(0.6,-0.11,'Twitter: @peterdevietien   Data: EIA','fontsize',17,'units','normalized')

%%
filename='days-remaining-usa';
print(sprintf('~/projects/eia/post/%s',filename),'-dpng')