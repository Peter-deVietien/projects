cca

dirname_base={'apr21','oct21','apr22'};
lgnnames={'April ''21','October ''21','April ''22'};

dirname_base={'mar22','apr22'};
lgnnames={'March ''22','April ''22'};


nd=numel(dirname_base);

for i=1:nd
    dirnames{i}=[dirname_base{i},'_base.xlsx'];
end


lgs=[];
for i=1:nd
    
    [dates,inven]=load_steo_usa_inven(dirnames{i});
    hold on
    p=plot(dates,inven,'linewidth',2);
    p.Color(4)=0.6;
    hold off
    lgs=[lgs {dirname_base{i}}];
    
end



grid on

ax=gca;
ax.FontSize=18;


%yticks=[90:1:106];
%ax.YTick=yticks;
ytickformat('%,.0d')
ax=gca;
ax.YAxis(1).Exponent=0;

%ylim([92 105])
yliml=ylim;


ylbl=ylabel('U.S. Commercial Inventory [mb]');
%ylbl.Position(1)=-160;



%% Load EIA weekly data

addpath('~/projects/eia/code-mat')
series_id='PET.WTESTUS1.W';
d=load_eia_series(series_id);
d=process_weekly_data(d);

%% Manual Add
eia_weekly_manual_data

d.dates=[d.dates; mandates];
d.y=[d.y;maninventoriesnospr];

%% 
ind=find(d.dates>datetime(2017,1,1),1,'first');
d.dates=d.dates(ind:end);
d.y=d.y(ind:end)/1000;

%%
hold on
plot(d.dates,d.y,'linewidth',3,'color','m')
hold off
lgnnames=[lgnnames {'Weekly EIA Total Inventory'}];


yyaxis right
ylim(yliml)
ax.YAxis(2).Color='k';


ytickformat('%,.0d')
ax=gca;
ax.YAxis(2).Exponent=0;

ax.YTick=yticks;
ax.FontSize=20;


%% Adornments

if 0
sdate=datetime(2021,10,1);
ind=find(d.dates>sdate,1,'first');

tdays=[d.dates(ind:end)];
ty=d.y(ind:end);
tndays=days(tdays-tdays(1));

[yo,mo,x,bo]=least_squares(tndays,ty);

hold on
p=plot(sdate+tndays,yo,'linewidth',6,'linestyle','-','color',[0.3010 0.7450 0.9330]);
hold off
p.Color(4)=0.5;

lgnnames=[lgnnames {sprintf('%s Trend: %.2fmbpd',datestr(sdate),mo)}];
end


%%
xlim([datetime(2019,6,1) datetime(2022,12,1)])

fig=gcf;
fig.Position=[95 191 941 675];

lastdatestr='April 6th';
title_str=sprintf('U.S. Commercial Crude and Product Inventories\nIncludes %s Weekly EIA Release',lastdatestr);
ttl=title(title_str,'fontsize',22);
%ttl.Position(2)=3.3131e+03;

lgn=legend(lgnnames);
lgn.FontSize=22;
%lgn.Position=[0.5818 0.7488 0.3231 0.1622];

text(0.2,-0.1,'Truth Social: @pdv  |  Twitter: @peterdevietien  |  Data:  EIA STEOs & EIA','fontsize',18,'units','normalized')

%%
pngname='~/projects/eia/post/steo_weekly_usa_inventory';
print(pngname,'-dpng')