cca

dirname_base={'may21','nov21','may22'};
lgnnames={'STEO May ''21','STEO November ''21','STEO May ''22'};


dirname_base={'jun22'};
lgnnames={'STEO June ''22'};


nd=numel(dirname_base);

for i=1:nd
    dirnames{i}=[dirname_base{i},'_base.xlsx'];
end

scale=2;
fig=figure;
fig.Position=[75.8000 342 1200/scale 675/scale];

lgs=[];
for i=1:nd
    
    [dates,commerc,spr]=load_steo_usa_inven(dirnames{i});
    tot_inven=commerc+spr;
    
    hold on
    p=plot(dates,tot_inven/1000,'linewidth',2);
    p.Color(4)=0.6;
    hold off
    lgs=[lgs {dirname_base{i}}];
    
end

grid on

ax=gca;
ax.FontSize=15;

ax=gca;
%ax.XTickLabel={'2018','2019','','2020','','2021','','2022','','2023'};

yl=[1.5 2.2];
ylim(yl)
ytickformat('%.1f')

ylbl=ylabel('Inventory [billion barrels]');

%% Load EIA weekly data

addpath('~/projects/eia/code-mat')
series_id='PET.WTTSTUS1.W';
d=load_eia_series(series_id);
d=process_weekly_data(d);

%% Manual Add
eia_weekly_manual_data

d.dates=[d.dates; mandates];
d.y=[d.y;maninventories];

%% 
ind=find(d.dates>datetime(1990,1,1),1,'first');
d.dates=d.dates(ind:end);
d.y=d.y(ind:end)/1e6;

%%
hold on
plot(d.dates,d.y,'linewidth',3,'color','m')
hold off
lgnnames=[lgnnames {'Weekly EIA'}];

%%
yyaxis right

ax=gca;
ax.YAxis(2).Color='k';
ax.Position=[0.1300 0.1274 0.7750 0.7872];

ylim(yl)
ytickformat('%.1f')

%%
xlim([datetime(2010,1,1) datetime(2023,1,1)])

title_str=sprintf('Total U.S. Petroleum Inventories: STEO and Weeklies');
ttl=title(title_str,'fontsize',16);

lgn=legend(lgnnames);
lgn.FontSize=12;
lgn.Position=[0.1342 0.8086 0.1975 0.0994];

lastdatestr=datestr(d.dates(end));
t1=text(0.0861,0.0288,sprintf('All Products and Crude Including SPR.  Data Week Ending %s',lastdatestr),'fontsize',13,'units','normalized');
t2=text(0.24,-0.1326,'Truth Social: @pdv  |  Twitter: @peterdevietien  |  Data:  EIA STEOs & EIA','fontsize',11,'units','normalized');

%%
pngname='~/projects/eia/post/steo_weekly_usa_inventory';
print(pngname,'-dpng')