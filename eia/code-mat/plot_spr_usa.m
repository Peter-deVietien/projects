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
fig=gcf;
fig.Position=[203 305 847 561];

plot(d1.dates,d1.y/1000,'linewidth',4,'color',leftycolor)

grid on
ax=gca;
ax.FontSize=19;

yl=ylim;
ylim([0 yl(2)])

ylabel(sprintf('SPR [mb]'))


title(sprintf('SPR Crude Inventories in USA'),'fontsize',25)

text(0.7,0.03,sprintf('Last date: %s',datestr(d1.dates(end),'mmm dd yyyy')),'fontsize',18,'units','normalized')

text(0.3,-0.1,'Truth Social: @pdv  |  Twitter: @peterdevietien  |  Data: EIA','fontsize',15,'units','normalized')
%%

%%
print('~/projects/eia/post/spr_usa','-dpng')
