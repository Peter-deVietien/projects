cca
%dirname_base={'jan21','feb21','mar21','apr21','may21','jun21','jul21','aug21','sep21','oct21','nov21','dec21','jan22'}
%dirname_base={'jan21','mar21','may21','jul21','sep21','nov21','jan22'};
%lgnnames={'Jan ''21','Mar ''21','May ''21','July ''21','Sep ''21','Nov ''21','Jan ''22'};

dirname_base={'mar22'};
lgnnames={'March STEO ''22'};

nd=numel(dirname_base);

for i=1:nd
    dirnames{i}=[dirname_base{i},'_base.xlsx'];
end

steo_color=[0 0.4470 0.7410 0.6];
substitute_color=[0 0.4470 0.7410 1];
    
addpath('..')
[gdates,gconsumption]=load_steo_global_consump(dirnames{1});
[udates,uconsumption]=load_steo_usa_consum(dirnames{1});

%% Load EIA weekly data

series_id='PET.WRPUPUS2.4';
d=load_eia_series(series_id);
d=process_weekly_data(d);

wdates=d.dates;
weekly_consump=d.y;

%% Manual Add
wdates=[wdates;datetime(2022,2,25)];
weekly_consump=[weekly_consump;21734];

%%

ind=find(wdates>datetime(2018,1,1),1,'first');
wdates=wdates(ind:end);
weekly_consump=weekly_consump(ind:end);



%%
ngdays=days(gdates-datetime(2018,1,1));
nwdays=days(wdates-wdates(1));

ppgconsump=spline(ngdays,gconsumption,nwdays);

ngdays=days(udates-datetime(2018,1,1));
ppuconsump=spline(ngdays,uconsumption,nwdays);

subconsumption=ppgconsump-ppuconsump+weekly_consump/1000;

%%
p=plot(gdates,gconsumption,'linewidth',3,'color',steo_color);
p.Color(4)=0.2;
hold on
plot(wdates,subconsumption,'linewidth',3,'color',substitute_color)
hold off    

grid on

ax=gca;
ax.FontSize=18;


yticks=[90:1:106];
ax.YTick=yticks;
ytickformat('%,.0d')

ylim([92 105])
yliml=ylim;


ylbl=ylabel('Global Consumption [mbpd]');
ylbl.Position(1)=-160;

yyaxis right

ylim(yliml)
ax.YAxis(2).Color='k';

ytickformat('%,.0d')
ax=gca;
ax.YTick=yticks;

fig=gcf;
fig.Position=[95 191 941 675];

lastdatestr='February 24th';
ttl=title(sprintf('February ''22 STEO Consumption\nU.S. STEO Substituted with 4 Wk Avg Product Supplied\nIncludes %s EIA Release',lastdatestr),'fontsize',22);
%ttl.Position(2)=3.3131e+03;

text(datetime(2021,8,1),90.7,'@peterdevietien     Data: EIA STEOs','fontsize',18)


lgn=legend('Feb ''22 STEO Consumption','U.S. 4 Wk Product Supplied Substituted');
lgn.Position=[0.2202 0.7608 0.3533 0.0919];

%%
pngname='~/projects/eia/post/steo_substitute_consumption_usa';
print(pngname,'-dpng')