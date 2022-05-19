cca

dirname_base={'apr22','may22'};
lgnnames={'STEO April 22','STEO May 22'};

nd=numel(dirname_base);

for i=1:nd
    dirnames{i}=[dirname_base{i},'_base.xlsx'];
end

prod_color=[0 0.4470 0.7410];
consum_color=[0.8500 0.3250 0.0980];

scale=2;
fig=figure;
fig.Position=[75.8000 342 1200/scale 675/scale];


lgs=[];
    
[fpdates,fproduction]=load_steo_global_production(dirnames{1});
[fcdates,fconsumption]=load_steo_global_consumption(dirnames{1});

[mpdates,mproduction]=load_steo_global_production(dirnames{2});
[mcdates,mconsumption]=load_steo_global_consumption(dirnames{2});

hold on
p=plot(fpdates,fproduction,'linewidth',4,'color',prod_color);
p.Color(4)=0.4;
p=plot(mpdates,mproduction,'linewidth',5,'color',prod_color);
p.Color(4)=1;
hold off
lgs=[lgs {'April ''22 Production'}];
lgs=[lgs {'May ''22 Production'}];
    


hold on
p=plot(fcdates,fconsumption,'linewidth',2,'color',consum_color);
p.Color(4)=0.2;
plot(mcdates,mconsumption,'linewidth',3,'color',consum_color)
hold off
lgs=[lgs {'April ''22 Consumption'}];
lgs=[lgs {'May ''22 Consumption'}];



lgn=legend(lgs,'fontsize',15);
lgn.Position=[0.5750 0.1247 0.3183 0.2300];

grid on

ax=gca;
ax.FontSize=16;

yticks=[90:106];
ax.YTick=yticks;
ytickformat('%,.0f')
ax=gca;
ax.YAxis(1).Exponent=0;

ylim([98 103.5])
yliml=ylim;


ylbl=ylabel('Global Production [mbpd]');
%ylbl.Position(1)=-230;

yyaxis right
ylim(yliml)
ax.YAxis(2).Color='k';


ytickformat('%,.0f')
ax=gca;
ax.YAxis(2).Exponent=0;

ax.YTick=yticks;

xlim([datetime(2022,2,1) datetime(2024,1,1)])
ax.XAxis.TickLabelFormat='MMM yy';

ttl=title('STEOs for Global Production and Consumption','fontsize',18);
%ttl.Position(2)=3.3131e+03;

t1=text(0.5034,-0.1146,'Twitter: @peterdevietien     Data: EIA STEOs','fontsize',12,'units','normalized');

%%
pngname='~/projects/eia/post/steo_global_production_consumption';
print(pngname,'-dpng')