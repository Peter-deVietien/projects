cca
%dirname_base={'jan21','feb21','mar21','apr21','may21','jun21','jul21','aug21','sep21','oct21','nov21','dec21','jan22'}
%dirname_base={'jan21','mar21','may21','jul21','sep21','nov21','jan22'};
%lgnnames={'Jan ''21','Mar ''21','May ''21','July ''21','Sep ''21','Nov ''21','Jan ''22'};

dirname_base={'jan21','apr21','jul21','oct21','jan22'};
lgnnames={'Jan ''21','Apr ''21','Jul ''21','Oct ''21','Jan ''22'};


dirname_base={'feb21','apr21','jun21','aug21','oct21','dec21','jan22','feb22'}
lgnnames={'Feb ''21','Apr ''21','Jun ''21','Aug ''21','Oct ''21','Dec ''21','Jan ''22','Feb ''22'};

dirname_base={'feb21','aug21','feb22'}
lgnnames={'February ''21 STEO','August ''21 STEO','February ''22 STEO'};

dirname_base={'mar21','sep21','mar22'}
lgnnames={'STEO March 21','STEO September 21','STEO March 22'};


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


ind=find(d.dates>datetime(2017,1,1),1,'first');
d.dates=d.dates(ind:end);
d.y=d.y(ind:end)/1000;

%% Manual Add
d.dates=[d.dates; datetime(2022,3,18)];
d.y=[d.y; 1.1368e3];

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
%xticks=[datetime(2018,1,1):calmonths(24):datetime(2022,1,1)];
%ax.XTick=xticks;

fig=gcf;
fig.Position=[95 191 941 675];

lastdatestr='March 16th';
title_str=sprintf('U.S. Commercial Crude and Product Inventories\nIncludes %s EIA Release',lastdatestr);
ttl=title(title_str,'fontsize',22);
%ttl.Position(2)=3.3131e+03;

lgn=legend(lgnnames);
%lgn.Position=[0.6020 0.6152 0.1716 0.1785];
lgn.FontSize=22;
lgn.Position=[0.5818 0.7488 0.3231 0.1622];

text(datetime(2021,5,1),1115,'Twitter: @peterdevietien     Data:  EIA STEOs & EIA','fontsize',18)

%%
pngname='~/projects/eia/post/steo_weekly_usa_inventory';
print(pngname,'-dpng')