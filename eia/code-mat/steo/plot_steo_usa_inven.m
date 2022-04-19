cca
%dirname_base={'jan21','feb21','mar21','apr21','may21','jun21','jul21','aug21','sep21','oct21','nov21','dec21','jan22'}
%dirname_base={'jan21','mar21','may21','jul21','sep21','nov21','jan22'};
%lgnnames={'Jan ''21','Mar ''21','May ''21','July ''21','Sep ''21','Nov ''21','Jan ''22'};

dirname_base={'feb21','apr21','jun21','aug21','oct21','dec21','jan22','feb22'}
lgnnames={'Feb ''21','Apr ''21','Jun ''21','Aug ''21','Oct ''21','Dec ''21','Jan ''22','Feb ''22'};


dirname_base={'mar21','sep21','feb22','mar22'}
lgnnames={'STEO March 21','STEO September 21','STEO February 22','STEO March 22'};

dirname_base={'Mar22','apr22'};
lgnnames={'March ''22','April ''22'};



nd=numel(dirname_base);

for i=1:nd
    dirnames{i}=[dirname_base{i},'_base.xlsx'];
end


lgs=[];
for i=1:nd
    
    [dates,inven]=load_steo_usa_inven(dirnames{i});
    hold on
    plot(dates,inven,'linewidth',2)
    hold off
    lgs=[lgs {dirname_base{i}}];
    
end

lgn=legend(lgnnames);
lgn.Position=[0.4758 0.1529 0.1031 0.2363];

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

yyaxis right
ylim(yliml)
ax.YAxis(2).Color='k';


ytickformat('%,.0d')
ax=gca;
ax.YAxis(2).Exponent=0;

ax.YTick=yticks;

fig=gcf;
fig.Position=[95 191 941 675];

ttl=title('STEO Projections for U.S. Commercial Inventories','fontsize',22);
%ttl.Position(2)=3.3131e+03;

text(datetime(2017,1,1),91,'@peterdevietien     Data: EIA STEOs','fontsize',18)

%%
pngname='~/projects/eia/post/steo_usa_inventory';
print(pngname,'-dpng')