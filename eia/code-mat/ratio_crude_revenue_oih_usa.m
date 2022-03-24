cca

%%
series1='PET.RWTC.W';

%%
[dinit1,metadata]=load_eia_series(series1);
d1=process_weekly_data(dinit1);

addpath('steo')
filename='weekly_feb25.xls';
[wdates,weekly_prod]=load_weekly_domestic(filename);

ticker='OIH';
d=load_ticker_data(ticker);



%%
leftycolor=[0 0.4470 0.7410];
rightycolor=[0.8500 0.3250 0.0980];

%%
prodates=wdates;
pridates=d1.dates;

prodatesn=days(prodates-pridates(1));
pridatesn=days(pridates-pridates(1));

prod=spline(prodatesn,weekly_prod,pridatesn)/1000;
price=d1.y;

[idates,infl]=inflation_vs_t(pridates);

price_infl=price./infl;

revenue_infl=prod.*price_infl;

%%
tdates=d.dates_close;
tprice=d.close;

ind=find(pridates>tdates(1),1,'first');
pridates=pridates(ind:end);
revenue_infl=revenue_infl(ind:end);
pridatesn=days(pridates-pridates(1));


tdatesn=days(tdates-pridates(1));


[tdates,tinfl]=inflation_vs_t(tdates);

tprice_infl=tprice./tinfl;

tprice=spline(tdatesn,tprice_infl,pridatesn);

price_to_sales=tprice./revenue_infl;

%%

fig=gcf;
fig.Position=[125 385 1007 550];

p=plot(pridates,price_to_sales,'linewidth',3,'color',leftycolor);
p.Color(4)=0.5;

%%
grid on
%xlim([d1.dates(100) d1.dates(end)+calmonths(12)])

ytickformat('%,.1f')
ax=gca;
ax.YAxis(1).Exponent=0;

ax.FontSize=22;

lylbl=ylabel('$OIH Price to Sales');

tt=title(sprintf('$OIH U.S. Industry Wide Price to Sales Ratio'),'fontsize',30);

xl=xlim;

xlim([xl(1) xl(2)+calmonths(3)])

text(0.55,-0.11,'Twitter: @peterdevietien   Data: EIA, St. Louis Fed','fontsize',17,'FontName','Times','units','normalized')

text(0.005,0.02,'Daily Gross Revenue = U.S. Daily Domestic Production * $WTI in 2022 dollars','fontsize',16,'units','normalized')
text(0.005,0.057,sprintf('Price to Sales = $OIH / Daily Gross Revenue'),'fontsize',16,'units','normalized')
text(0.005,0.057+0.037,sprintf('Data includes %s',datestr(pridates(end),'mmm dd yyyy')),'fontsize',16,'units','normalized')
%%
print('~/projects/eia/post/ratio_crude_revenue_OIH_usa','-dpng')
