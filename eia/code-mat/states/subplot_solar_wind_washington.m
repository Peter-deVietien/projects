cca

series_key1='ELEC.GEN.WND-WA-99.M';
series_key2='ELEC.GEN.TSN-WA-99.M';

addpath('../')
[dinit1,metadata1]=load_eia_series(series_key1);
d1=process_monthly_data(dinit1);

[dinit2,metadata2]=load_eia_series(series_key2);
d2=process_monthly_data(dinit2);

%%
leftycolor=[0 0.4470 0.7410];
rightycolor=[0.9290 0.6940 0.1250];

%%
dt=@(y,m,d)datetime(y,m,d);

ind=find(d1.dates>d2.dates(1),1,'first')-1;

d3.dates=d1.dates(ind:end);
d3.y=(d1.y(ind:end)/max(d1.y(ind:end)) + d2.y/max(d2.y))/2;

%%
x_lim=[datetime(2017,1,1) datetime(2022,1,1)];

fig=gcf;
fig.Position=[476 211 786 655];

subplot(3,1,1)
plot(d1.dates,d1.y,'linewidth',3,'color',leftycolor)
title('Wind Energy Monthly [GWh]')

ax1=gca;
ax1.FontSize=18;
ax1.YGrid='on';
ax1.YTick=[0:250:1000];
ylim([0 1000])
xlim(x_lim)


subplot_solar_wind_winter_bounds

%%
subplot(3,1,2)
plot(d2.dates,d2.y,'linewidth',3,'color',leftycolor)
title('Solar Energy Monthly [GWh]')

ax2=gca;
ax2.FontSize=18;
ax2.YTick=[0:10:50];
ax2.YGrid='on';

xlim(x_lim)
subplot_solar_wind_winter_bounds
ylim([0 50])


%%
subplot(3,1,3)
plot(d3.dates,d3.y*100,'linewidth',3,'color',leftycolor)
title('Normalized and Combined [Percent]')

ax3=gca;
ax3.FontSize=18;
ax3.YTick=[0:0.25:1]*100;
ax3.YGrid='on';
xlim(x_lim)

subplot_solar_wind_winter_bounds
ylim([0 100])

%%

ax1.Position=[0.1300 0.6879 0.7750 0.2015];
ax2.Position=[0.1300 0.3867 0.7750 0.2015];
ax3.Position=[0.1300 0.0902 0.7750 0.2015];

%%


%%

text(0.5,4.37,sprintf('Solar and Wind in Washington State'),'fontsize',31,'units','normalized','horizontalalignment','center')

text(0.5,-0.3,'Twitter: @peterdevietien  Data: EIA','fontsize',18,'units','normalized')

print('~/projects/eia/post/subplot_solar_wind_washington','-dpng')