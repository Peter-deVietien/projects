cca
%dirname_base={'jan21','feb21','mar21','apr21','may21','jun21','jul21','aug21','sep21','oct21','nov21','dec21','jan22'}
%dirname_base={'jan21','mar21','may21','jul21','sep21','nov21','jan22'};
%lgnnames={'Jan ''21','Mar ''21','May ''21','July ''21','Sep ''21','Nov ''21','Jan ''22'};

dirname_base={'jan21','apr21','jul21','oct21','jan22'};
lgnnames={'Jan ''21','Apr ''21','Jul ''21','Oct ''21','Jan ''22'};

dirname_base={'mar21','sep21','feb22','mar22'}
lgnnames={'STEO March 21','STEO September 21','STEO February 22','STEO March 22'};

dirname_base={'feb22','mar22'};
lgnnames={'STEO February 22','STEO March 22'};

nd=numel(dirname_base);

for i=1:nd
    dirnames{i}=[dirname_base{i},'_base.xlsx'];
end

prod_color=[0 0.4470 0.7410];
consum_color=[0.8500 0.3250 0.0980];

lgs=[];
    
[fpdates,fproduction]=load_steo_global_production(dirnames{1});
[fcdates,fconsumption]=load_steo_global_consumption(dirnames{1});

[mpdates,mproduction]=load_steo_global_production(dirnames{2});
[mcdates,mconsumption]=load_steo_global_consumption(dirnames{2});

hold on
p=plot(fpdates,fproduction,'linewidth',3,'color',prod_color);
p.Color(4)=0.2;
p=plot(mpdates,mproduction,'linewidth',5,'color',prod_color);
p.Color(4)=1;
hold off
lgs=[lgs {'February ''22 Production'}];
lgs=[lgs {'March ''22 Production'}];
    


hold on
p=plot(fcdates,fconsumption,'linewidth',2,'color',consum_color);
p.Color(4)=0.2;
plot(mcdates,mconsumption,'linewidth',3,'color',consum_color)
hold off
lgs=[lgs {'February ''22 Consumption'}];
lgs=[lgs {'March ''22 Consumption'}];



lgn=legend(lgs,'fontsize',25);
lgn.Position=[0.1929 0.7793 0.2625 0.0941];

grid on

ax=gca;
ax.FontSize=24;

yticks=[90:0.5:106];
ax.YTick=yticks;
ytickformat('%,.1f')
ax=gca;
ax.YAxis(1).Exponent=0;

ylim([99 104.5])
yliml=ylim;


ylbl=ylabel('Global Production [mbpd]');
ylbl.Position(1)=-230;

yyaxis right
ylim(yliml)
ax.YAxis(2).Color='k';


ytickformat('%,.1f')
ax=gca;
ax.YAxis(2).Exponent=0;

ax.YTick=yticks;



fig=gcf;
fig.Position=[95 191 941 675];

xlim([datetime(2022,2,1) datetime(2024,1,1)])
ax.XAxis.TickLabelFormat='MMM yy';

ttl=title('STEOs for Global Production and Consumption','fontsize',26);
%ttl.Position(2)=3.3131e+03;

text(0.54,-0.1,'Twitter: @peterdevietien     Data: EIA STEOs','fontsize',18,'units','normalized')

%%
pngname='~/projects/eia/post/steo_global_production_consumption';
print(pngname,'-dpng')