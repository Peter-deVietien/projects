cca

dirname_base={'apr21','oct21','apr22'};
lgnnames={'April ''21','October ''21','April ''22'};

nd=numel(dirname_base);

for i=1:nd
    dirnames{i}=[dirname_base{i},'_base.xlsx'];
end


lgs=[];
for i=1:nd
    [dates,inven]=load_steo_oecd_inven(dirnames{i});
    disp(inven(end))
    
    %% Get month/year
    

    hold on
    plot(dates,inven,'linewidth',3)
    hold off
    lgs=[lgs {dirname_base{i}}];
    
end


grid on

ax=gca;
ax.FontSize=22;

yliml=ylim;
ylbl=ylabel('OECD Commercial Inventory [mb]');
ylbl.Position(1)=-240;

    
ytickformat('%,.0d')
ax=gca;
ax.YAxis(1).Exponent=0;

yyaxis right
ylim(yliml)
ax.YAxis(2).Color='k';


ytickformat('%,.0d')
ax=gca;
ax.YAxis(2).Exponent=0;

fig=gcf;
fig.Position=[95 191 941 675];

ttl=title('STEO Projections for OECD Commercial Inventories','fontsize',22);
ttl.Position(2)=3.3131e+03;

text(0.52,-0.09,'Twitter: @peterdevietien     Data: EIA STEOs','fontsize',18,'units','normalized')

if 0
    
    
end


%% Adornments
if 0

    polynum=1;
    edate=datetime();
    sdate=datetime(2021,6,1);
    
    speriod=calmonths(3);
    sdates=[sdate:calmonths:edate];
    
    f=load_trendline_dates(sdates,polynum);

hold on
plot(fitx,fit,'linewidth',2,'linestyle','-','color',[0.3010 0.7450 0.9330])
hold off

lgnnames=[lgnnames {sprintf('Trend: %.2fmbpd',pf(1)/30)}];

end


%%
lgn=legend(lgnnames,'fontsize',22);
%lgn.Position=[0.6291 0.6926 0.2184 0.1141];


text(0.3,0.15,['600mb drop Aug ''20 - Feb ''22',...
    newline,'=',newline,'1.1mbpd draw for 18 months for OECD'],'units','normalized','fontsize',22,'horizontalalignment','center');


%%
pngname='~/projects/eia/post/steo_oecd_inventories';
print(pngname,'-dpng')