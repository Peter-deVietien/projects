cca

dirname_base={'apr22','may22'};
lgnnames={'April ''22 STEO','May ''22 STEO'};

nd=numel(dirname_base);

for i=1:nd
    dirnames{i}=[dirname_base{i},'_base.xlsx'];
end

scale=2;
fig=figure;
fig.Position=[75.8000 342 1200/scale 675/scale];

for i=1:nd
    
    [dates,inven]=load_steo_usa_inven(dirnames{i});
    hold on
    plot(dates,inven,'linewidth',2)
    hold off
    
end

lgn=legend(lgnnames);
%lgn.Position=[0.4758 0.1529 0.1031 0.2363];

grid on

ax=gca;
ax.FontSize=16;

ytickformat('%,.0d')
ax.YAxis(1).Exponent=0;


ylbl=ylabel('U.S. Commercial Inventory [mb]');

yl=ylim;
yticks=ax.YTick;
ax.YTick=yticks;

yyaxis right
ylim(yl)
ax.YAxis(2).Color='k';


ytickformat('%,.0d')
ax=gca;
ax.YAxis(2).Exponent=0;

ax.YTick=yticks;


ttl=title('STEO Projections for U.S. Commercial Inventories','fontsize',18);

t1=text(0.5871,-0.111,'@peterdevietien     Data: EIA STEOs','fontsize',12,'units','normalized');

%%
pngname='~/projects/eia/post/steo_usa_inventory';
print(pngname,'-dpng')