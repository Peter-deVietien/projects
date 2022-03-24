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


lgs=[];
for i=1:nd
    
    [dates,production]=load_steo_global_production(dirnames{i});
    hold on
    plot(dates,production,'linewidth',4)
    hold off
    lgs=[lgs {dirname_base{i}}];
    
end

lgn=legend(lgnnames,'fontsize',25);
lgn.Position=[0.1929 0.7793 0.2625 0.0941];

grid on

ax=gca;
ax.FontSize=24;

yticks=[90:0.5:106];
ax.YTick=yticks;
ytickformat('%,.1f')
ax=gca;
ax.YAxis(1).Exponent=0;

ylim([99.5 104.5])
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

ttl=title('STEO Projections for Global Production','fontsize',26);
%ttl.Position(2)=3.3131e+03;

text(0.54,-0.1,'Twitter: @peterdevietien     Data: EIA STEOs','fontsize',18,'units','normalized')

%%
pngname='~/projects/eia/post/steo_global_production';
print(pngname,'-dpng')