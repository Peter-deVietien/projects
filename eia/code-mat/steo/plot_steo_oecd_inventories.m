cca

dirname_base={'may21','nov21','may22'};
lgnnames={'May ''21','November ''21','May ''22'};

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
    [dates,inven]=load_steo_oecd_inven(dirnames{i});
    disp(inven(end))
    
    %% Get month/year
    hold on
    plot(dates,inven,'linewidth',3)
    hold off
    
end


grid on

ax=gca;
ax.FontSize=16;

yliml=ylim;
ylbl=ylabel('OECD Commercial Inventory [mb]');
%ylbl.Position(1)=-240;

    
ytickformat('%,.0d')
ax=gca;
ax.YAxis(1).Exponent=0;

yyaxis right
ylim(yliml)
ax.YAxis(2).Color='k';


ytickformat('%,.0d')
ax=gca;
ax.YAxis(2).Exponent=0;

ttl=title('STEO Projections for OECD Commercial Inventories','fontsize',17);

t1=text(0.4985,-0.1155,'Twitter: @peterdevietien     Data: EIA STEOs','fontsize',12,'units','normalized');


%% Adornments


%%
lgn=legend(lgnnames,'fontsize',16);
%lgn.Position=[0.6291 0.6926 0.2184 0.1141];


%text(0.3,0.15,['600mb drop Aug ''20 - Feb ''22',...
%    newline,'=',newline,'1.1mbpd draw for 18 months for OECD'],'units','normalized','fontsize',22,'horizontalalignment','center');


%%
pngname='~/projects/eia/post/steo_oecd_inventories';
print(pngname,'-dpng')