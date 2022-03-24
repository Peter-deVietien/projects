cca
%dirname_base={'jan21','feb21','mar21','apr21','may21','jun21','jul21','aug21','sep21','oct21','nov21','dec21','jan22'}
%dirname_base={'jan21','mar21','may21','jul21','sep21','nov21','jan22'};
%lgnnames={'Jan ''21','Mar ''21','May ''21','July ''21','Sep ''21','Nov ''21','Jan ''22'};

%dirname_base={'jan21','apr21','jul21','oct21','jan22'};
%lgnnames={'Jan ''21','Apr ''21','Jul ''21','Oct ''21','Jan ''22'};


%dirname_base={'feb21','apr21','jun21','aug21','oct21','dec21','jan22','feb22'}
%lgnnames={'Feb ''21','Apr ''21','Jun ''21','Aug ''21','Oct ''21','Dec ''21','Jan ''22','Feb ''22'};

dirname_base={'mar22'};
lgnnames={'March 2022 STEO'};


nd=numel(dirname_base);

for i=1:nd
    dirnames{i}=[dirname_base{i},'_base.xlsx'];
end


lgs=[];
for i=1:nd
    
    [dates,inven]=load_steo_usa_consum(dirnames{i});
    hold on
    plot(dates,inven,'linewidth',2)
    hold off
    lgs=[lgs {dirname_base{i}}];
    
end



grid on

ax=gca;
ax.FontSize=20;


%yticks=[90:1:106];
%ax.YTick=yticks;
ytickformat('%,.0d')
ax=gca;

%ylim([92 105])
yliml=ylim;


ylbl=ylabel('U.S. Consumption [mbpd]');



%% Load EIA weekly data

addpath('~/projects/eia/code-mat')
series_id='PET.WRPUPUS2.4';
d=load_eia_series(series_id);
d=process_weekly_data(d);

ind=find(d.dates>datetime(2018,1,1),1,'first');
d.dates=d.dates(ind:end);
d.y=d.y(ind:end)/1000;

%% Manual Add
% d.dates=[d.dates; datetime(2022,3,4)];
% d.y=[d.y; 21.566];


hold on
plot(d.dates,d.y,'linewidth',3,'color',[0.8500 0.3250 0.0980 0.5])
hold off
lgnnames=[lgnnames {'4 Week Average Product Supplied'}];


yticks=[17:0.5:23];
ylim([17 23])
ax.YTick=yticks;

ytickformat('%,.1f')

yyaxis right
ylim(yliml)
ax.YAxis(2).Color='k';
ax=gca;
ax.YTick=yticks;


ytickformat('%,.1f')
ax=gca;
ax.YTick=yticks;



%% Adornments


%%
%xticks=[datetime(2018,1,1):calmonths(24):datetime(2022,1,1)];
%ax.XTick=xticks;

fig=gcf;
fig.Position=[95 191 941 675];

title_str=sprintf('U.S. Total Product Consumption\nMarch STEO vs 4 Week Avg EIA Data');
ttl=title(title_str,'fontsize',22);
%ttl.Position(2)=3.3131e+03;

lgn=legend(lgnnames,'fontsize',18);
lgn.Position=[0.2619 0.7786 0.3379 0.0704];

ylim([17 23])
xlim([datetime(2019,1,1) datetime(2022,12,1)])


text(0.42,0.025,sprintf('Weekly includes data for week ending %s',datestr(d.dates(end))),'units','normalized','fontsize',18)


text(0.45,-0.1,'Twitter: @peterdevietien     Data:  EIA STEOs & EIA','fontsize',18,'units','normalized')

ylbl.Position(1)=230;
ylbl.Position(2)=20;

%%
pngname='~/projects/eia/post/steo_weekly_usa_consumption';
print(pngname,'-dpng')