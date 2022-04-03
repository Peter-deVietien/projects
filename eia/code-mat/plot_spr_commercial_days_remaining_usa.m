cca

%%
series_key1='PET.WCSSTUS1.W';
series_key2='PET.WCESTUS1.W';
series_key3='PET.WRPUPUS2.4';

%%
[dinit1,metadata1]=load_eia_series(series_key1);
d1=process_weekly_data(dinit1);

[dinit2,metadata2]=load_eia_series(series_key2);
d2=process_weekly_data(dinit2);

[dinit3,metadata3]=load_eia_series(series_key3);
d3=process_weekly_data(dinit3);

%%
leftycolor=[0 0.4470 0.7410];
rightycolor=[0.8500 0.3250 0.0980];
%%
nd=numel(d3.dates)-1;

d1.dates=d1.dates(end-nd:end);
d2.dates=d2.dates(end-nd:end);

d1.y=d1.y(end-nd:end);
d2.y=d2.y(end-nd:end);

%%
fig=gcf;
fig.Position=[203 305 847 561];

plot(d1.dates,d1.y./d3.y,'linewidth',4,'color',leftycolor)

hold on
plot(d2.dates,d2.y./d3.y,'linewidth',4,'color',rightycolor)
hold off

grid on
ax=gca;
ax.FontSize=19;

yl=ylim;
ylim([0 yl(2)])

xl=xlim;
xlim([xl(1) xl(2)+calmonths(6)])

ylabel(sprintf('Days Remaining'))


lgn=legend('SPR Crude Inventories DR','Commercial Crude Inventories DR');
lgn.Position=[0.1296 0.7977 0.3566 0.0811];

title(sprintf('Days Remaining in USA\nSPR and Commercial Crude'),'fontsize',25)

text(0.7,0.025,sprintf('Last date: %s',datestr(d1.dates(end),'mmm dd yyyy')),'fontsize',18,'units','normalized')

text(0.4,-0.1,'Truth Social: @pdv  |  Twitter: @peterdevietien  |  Data: EIA','fontsize',15,'units','normalized')
%%

%%
print('~/projects/eia/post/spr_commercial_days_remaining_usa','-dpng')
