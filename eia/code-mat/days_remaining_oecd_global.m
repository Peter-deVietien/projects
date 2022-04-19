cca

%%
series_key1='STEO.PASC_OECD_T3.M';
series_key2='STEO.PATC_WORLD.M';

[dinit1,metadata1]=load_eia_series(series_key1);
d1=process_monthly_data(dinit1);

[dinit2,metadata2]=load_eia_series(series_key2);
d2=process_monthly_data(dinit2);

%% Clip to common times

sind=find(d2.dates==d1.dates(1));
d2.dates=d2.dates(sind:end);
d2.y=d2.y(sind:end);


eind=find(d1.dates==datetime(2022,3,1));

d1.dates=d1.dates(1:eind);
d1.y=d1.y(1:eind);

d2.dates=d2.dates(1:eind);
d2.y=d2.y(1:eind);

d1.dates=d1.dates+calmonths(1);
d2.dates=d2.dates+calmonths(1);
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
ax.FontSize=19;
ax.GridAlpha=0.08;

fig=gcf;
fig.Position=[144 341 892 525];

%%

ylbl=ylabel('Days Remaining');
ylbl.Position=[-50 31.5000 -1.0000];
yl=[25 38];
ylim(yl)
yt=ax.YTick;

yyaxis right

ylim(yl);
ax.YTick=yt;
ax.YAxis(2).Color='k';

xlim([datetime(2004,1,1) datetime(2022,6,1)])

k=listfonts;
nk=numel(k);
%for i = 1:1
    %fname=k{i};
    
    tstr=sprintf('Days Remaining\nOECD Inventory/Global Consumption\nApril STEO:  March Last Data on Plot');
    tt=title(tstr);
    tt.Position(2)=34.9;
    tt.Position(1)=3.300e+03;
    tt.FontSize=25;
    
    tt.FontName='Arial Unicode MS';%fname;
  %  pause(1)
 %   print(sprintf('fonts/%s',fname),'-dpng')
%end

text(0.5,-0.1,'Twitter: @peterdevietien   Data: April STEO','fontsize',17,'units','normalized')

%%
filename='days-remaining-oecd-global';
print(sprintf('~/projects/eia/post/%s',filename),'-dpng')