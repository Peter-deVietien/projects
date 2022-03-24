cca

%%
series_key='ELEC.PRICE.CA-RES.Q';

%%
data=load_eia_series(series_key);
data=process_quarterly_data(data);

%%
data.yoy=zeros(data.nx(1),1);

for i=data.nx(1):-1:5
    data.yoy(i)=data.y(i)/data.y(i-4);
end

data.dates=data.dates(6:end);
data.yoy=data.yoy(6:end);

%%
leftycolor=[0 0.4470 0.7410];
rightycolor=[0.8500 0.3250 0.0980];
%rightycolor=[0.6350 0.0780 0.1840];
%%

plot(data.dates,zeros(numel(data.yoy),1),'linewidth',1,'color','k')
hold on
h(1)=bar(data.dates,(data.yoy-1)*100,'facecolor',leftycolor,'edgecolor',leftycolor);
h(2)=plot([data.dates(1:end-1); data.dates(end)+days(100)],(ones(numel(data.yoy),1)*mean(data.yoy)-1)*100,'linewidth',5);
hold off

%%
grid on
ylim([-2 20])
xlim([datetime(2017,2,5) datetime(2021,10,1)])

ax=gca;
ax.FontSize=20;
ax.XTickLabelRotation=90;

%%
k=ax.XTickLabel;
k=regexprep(k,'Jan','Q1');
k=regexprep(k,'Jul','Q3');
ax.XTickLabel=k;

ylbl_l=ylabel('YoY Electricity Price [%]');
gca1=gca;

%%
evdates=[datetime(2017,1,1),datetime(2018,1,1),datetime(2019,1,1),datetime(2020,1,1),datetime(2021,1,1),datetime(2022,1,1)];
evperc = [260,354,511,658,803,1000]/21000*100;

yyaxis right
%ax2=axes()
%ylbl_l.Color='blue';
gca1.YAxis(1).Color=leftycolor;


hold on
h(3)=plot(evdates,evperc,'linewidth',4,'color',rightycolor);
hold off

ylim([0 6])
set(gca,'YColor',rightycolor)
ylabel('Percent EVs in CA fleet','color',rightycolor)

fig=gcf;
fig.Position=[476 365 797 501];

%%
lgn=legend(h,'Quarterly YoY Electricity Price','Twenty Year Average','Percent EVs in CA fleet');
lgn.FontSize=18;
lgn.Position=[0.1371 0.59 0.4523 0.1028];

%%
title(sprintf('California Residential Electricity Price\nYoY Quarterly Change'),'fontsize',22)

text(datetime(2017,2,20),0.27,sprintf('@peterdevietien\nData: EIA, Cali Energy Commission'),'fontsize',14)

%%
pngname=sprintf('~/projects/eia/post/electricity/electricity_quarterly_yoy_CA');
print(pngname,'-dpng')