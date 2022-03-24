cca
%dirname_base={'jan21','feb21','mar21','apr21','may21','jun21','jul21','aug21','sep21','oct21','nov21','dec21','jan22'}
%dirname_base={'jan21','mar21','may21','jul21','sep21','nov21','jan22'};
%lgnnames={'Jan ''21','Mar ''21','May ''21','July ''21','Sep ''21','Nov ''21','Jan ''22'};

dirname_base={'feb22'};
lgnnames={'February STEO ''22'};

nd=numel(dirname_base);

for i=1:nd
    dirnames{i}=[dirname_base{i},'_base.xlsx'];
end

steo_color=[0 0.4470 0.7410 0.6];
substitute_color=[0 0.4470 0.7410 1];
    
[gdates,gproduction]=load_steo_global_production(dirnames{1});
[udates,uproduction]=load_steo_usa_product(dirnames{1});

%% Load EIA weekly data
filename='weekly_mar16.xls';
[wdates,weekly_prod]=load_weekly_production(filename);

ind=find(wdates>datetime(2018,1,1),1,'first');
wdates=wdates(ind:end);
weekly_prod=weekly_prod(ind:end);

%% Manual Add

%%
ngdays=days(gdates-datetime(2018,1,1));
nwdays=days(wdates-wdates(1));

ppgprod=spline(ngdays,gproduction,nwdays);

ngdays=days(udates-datetime(2018,1,1));
ppuprod=spline(ngdays,uproduction,nwdays);

newprod=ppgprod-ppuprod+weekly_prod/1000;

%%
p=plot(gdates,gproduction,'linewidth',3,'color',steo_color);
p.Color(4)=0.2;
hold on
plot(wdates,newprod,'linewidth',3,'color',substitute_color)
hold off    

grid on

ax=gca;
ax.FontSize=18;


yticks=[90:1:106];
ax.YTick=yticks;
ytickformat('%,.0d')

ylim([96 104])
yliml=ylim;


ylbl=ylabel('Global Production [mbpd]');
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
ttl=title(sprintf('February ''22 STEO Production\nSubstituted with 4 Wk Domestic and Other Production\nIncludes %s EIA Release',lastdatestr),'fontsize',22);
%ttl.Position(2)=3.3131e+03;

text(datetime(2021,8,1),91,'@peterdevietien     Data: EIA STEOs','fontsize',18)


lgn=legend('Feb ''22 STEO Production','U.S. 4 Wk Avg Production Substituted');
lgn.Position=[0.3629 0.7622 0.3422 0.0919];

%%
pngname='~/projects/eia/post/steo_substitute_production_usa';
print(pngname,'-dpng')