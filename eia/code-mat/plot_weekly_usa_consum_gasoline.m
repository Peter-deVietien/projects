cca

leftycolor=[0 0.4470 0.7410];
rightycolor=[0.8500 0.3250 0.0980];

scale=2;
fig=figure;
fig.Position=[75.8000 342 1200/scale 675/scale];

%% Load EIA weekly data

addpath('~/projects/eia/code-mat')
series_id='PET.WGFUPUS2.4';
c=load_eia_series(series_id);
c=process_weekly_data(c);

series_id='PET.EMM_EPMR_PTE_NUS_DPG.W';
g=load_eia_series(series_id);
g=process_weekly_data(g);

%%
lgnnames=[];
plot(c.dates,c.y/1000,'linewidth',1,'color',leftycolor)
lgnnames=[lgnnames {'Gasoline Consumption'}];

ylabel('Gasoline Consumption [mbpd]')
ylim([7.5 10.25]);

%%
yyaxis right

[bd,infl]=inflation_vs_t(g.dates);

plot(g.dates,g.y./infl,'linewidth',1,'color',rightycolor)
lgnnames=[lgnnames {'Gasoline price inflation adjusted'}];

ylabel('Gasoline Price [2022 USD]')


ax=gca;
ax.YAxis(1).Color=leftycolor;
ax.YAxis(2).Color=rightycolor;
ax.YGrid='on';
ax.Position=[0.1300 0.1274 0.7750 0.7970];
ax.FontSize=14;

%ylim(y_lim)


%%
title_str=['U.S. Gasoline Consumption and Price'];
ttl=title(title_str,'fontsize',16);

lgn=legend(lgnnames,'fontsize',13);
lgn.Position=[0.1295 0.819 0.4017 0.1053];

xlim([datetime(2018,1,1) datetime()+caldays(15)])

t1=text(0.618,0.0288,sprintf('Data Week Ending %s',datestr(c.dates(end))),'units','normalized','fontsize',12);
t2=text(0.4431,-0.1327,'Truth Social: @pdv  |  Twitter: @peterdevietien  |  Data: EIA','fontsize',10,'units','normalized');

%%
pngname='~/projects/eia/post/steo_weekly_usa_consum_brent';
print(pngname,'-dpng')