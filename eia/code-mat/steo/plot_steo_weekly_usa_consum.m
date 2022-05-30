cca

dirname_base={'may22'};
lgnnames={'May 2022 STEO'};

nd=numel(dirname_base);

for i=1:nd
    dirnames{i}=[dirname_base{i},'_base.xlsx'];
end

scale=2;
fig=figure;
fig.Position=[75.8000 342 1200/scale 675/scale];

lgs=[];
for i=1:nd
    
    [dates,inven]=load_steo_usa_consum(dirnames{i});
    hold on
    plot(dates,inven,'linewidth',2)
    hold off
    lgs=[lgs {dirname_base{i}}];
    
end

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
d=load_eia_series(series_id);
d=process_weekly_data(d);

%% Manual Add
eia_weekly_manual_data

d.dates=[d.dates;mandates];
d.y=[d.y;mantotal_product_4wk];

ind=find(d.dates>datetime(2018,1,1),1,'first');
d.dates=d.dates(ind:end);
d.y=d.y(ind:end)/1000;

%%
hold on
plot(d.dates,d.y,'linewidth',3,'color',[0.8500 0.3250 0.0980 0.5])
hold off
lgnnames=[lgnnames {'4 Week Average Product Supplied'}];

%%
yyaxis right

ax.YAxis(2).Color='k';
ax=gca;
ax.YTick=yticks;
ax.Position=[0.1300 0.1274 0.7750 0.7783];

ylim(y_lim)


%%
title_str=['U.S. Oil Products Consumption'];
ttl=title(title_str,'fontsize',16);

lgn=legend(lgnnames,'fontsize',13);
lgn.Position=[0.1433 0.7789 0.4017 0.1053];

xlim([datetime(2019,1,1) datetime(2023,1,1)])

t1=text(0.59,0.0288,'Includes May 25th Weekly Release','units','normalized','fontsize',12);
t2=text(0.3119,-0.1327,'Truth Social: @pdv  |  Twitter: @peterdevietien  |  Data:  EIA STEOs & EIA','fontsize',10,'units','normalized');

%%
pngname='~/projects/eia/post/steo_weekly_usa_consumption';
print(pngname,'-dpng')