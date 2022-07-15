cca

%%
series_key1='PET.WCSSTUS1.W';

%%
[dinit1,metadata1]=load_eia_series(series_key1);
d1=process_weekly_data(dinit1);

%%
leftycolor=[0 0.4470 0.7410];
rightycolor=[0.8500 0.3250 0.0980];
%%

%%

fig=figure;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

plot(d1.dates,d1.y/1000,'linewidth',4,'color',leftycolor)

hold on
plot([d1.dates(1) d1.dates(end)],[1 1]*d1.y(end)/1000,'linewidth',0.5,'color',leftycolor)
hold off

grid on
ax=gca;
ax.FontSize=14;

yl=ylim;
ylim([0 yl(2)])

xlim([datetime(1983,1,1) datetime(2024,1,1)])

ylabel(sprintf('SPR [mb]'))


title(sprintf('U.S. SPR Crude Inventories'),'fontsize',16)

text(0.7,0.03,sprintf('Last date: %s',datestr(d1.dates(end),'mmm dd yyyy')),'fontsize',11,'units','normalized')

text(0.3,-0.1,'Truth Social: @pdv  |  Twitter: @peterdevietien  |  Data: EIA','fontsize',11,'units','normalized')
%%

%%
print('~/projects/eia/post/spr_usa','-dpng')
