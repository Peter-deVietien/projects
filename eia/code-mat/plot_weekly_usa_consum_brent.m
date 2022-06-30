cca

leftycolor=[0 0.4470 0.7410];
rightycolor=[0.8500 0.3250 0.0980];

scale=2;
fig=figure;
fig.Position=[75.8000 342 1200/scale 675/scale];

grid on

yticks=[18:23];
y_lim=[18 23];

ax=gca;
ax.FontSize=16;
ax.YTick=yticks;
ax.XTickLabel={'2019','','2020','','2021','','2022','','2023'};
ylim(y_lim)

ylbl=ylabel('Consumption [mbpd]');

%% Load EIA weekly data

addpath('~/projects/eia/code-mat')
series_id='PET.WRPUPUS2.4';
c=load_eia_series(series_id);
c=process_weekly_data(c);

series_id='PET.RBRTE.D';
b=load_eia_series(series_id);
b=process_weekly_data(b);

%%
lgnnames=[];
plot(c.dates,c.y/1000,'linewidth',1,'color',leftycolor)
lgnnames=[lgnnames {'4 Week Average Product Supplied'}];

ylabel('Consumption [mbpd]')

%%
yyaxis right

[bd,infl]=inflation_vs_t(b.dates);

plot(b.dates,b.y./infl,'linewidth',1,'color',rightycolor)
lgnnames=[lgnnames {'Brent inflation adjusted'}];

ylabel('Brent Price [2022 USD]')


ax=gca;
ax.YAxis(1).Color=leftycolor;
ax.YAxis(2).Color=rightycolor;
ax.YGrid='on';
ax.Position=[0.1300 0.1274 0.7750 0.7496];
ax.FontSize=14;

%ylim(y_lim)


%%
title_str=['U.S. Oil Products Consumption',newline,'and Brent (infl. adjusted)'];
ttl=title(title_str,'fontsize',16);

lgn=legend(lgnnames,'fontsize',13);
lgn.Position=[0.1300 0.772 0.4017 0.1053];

xlim([datetime(2018,1,1) datetime()+caldays(15)])

t1=text(0.618,0.0288,sprintf('Data Week Ending %s',datestr(c.dates(end))),'units','normalized','fontsize',12);
t2=text(0.3119,-0.1327,'Truth Social: @pdv  |  Twitter: @peterdevietien  |  Data: EIA','fontsize',10,'units','normalized');

%%
pngname='~/projects/eia/post/steo_weekly_usa_consum_brent';
print(pngname,'-dpng')