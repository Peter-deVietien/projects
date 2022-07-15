cca

dirname_base={'jun22','jul22'};
lgnnames={'STEO June 22','STEO July 22'};

nd=numel(dirname_base);

for i=1:nd
    dirnames{i}=[dirname_base{i},'_base.xlsx'];
end


fig=figure;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

lgs=[];
for i=1:nd
    
    [dates,inven]=load_steo_global_consumption(dirnames{i});
    hold on
    plot(dates,inven,'linewidth',2)
    hold off
    lgs=[lgs {dirname_base{i}}];
    
end


grid on

ax=gca;
ax.FontSize=14;

yticks=[90:1:106];
ax.YTick=yticks;
ytickformat('%,.0d')
ax=gca;
ax.YAxis(1).Exponent=0;

ylim([97 104])
yliml=ylim;


ylbl=ylabel('Global Consumption [mbpd]');
%ylbl.Position(1)=-170;

yyaxis right
ylim(yliml)
ax.YAxis(2).Color='k';


ytickformat('%,.0d')
ax=gca;
ax.YAxis(2).Exponent=0;

ax.YTick=yticks;

ttl=title('STEO Projections for Global Consumption');
%ttl.Position(2)=3.3131e+03;


lgn=legend(lgnnames);
lgn.Position=[0.1333 0.8166 0.2625 0.1024];

xlim([datetime(2022,1,1) datetime(2024,1,1)])

text(0.54,-0.105,'Twitter: @peterdevietien     Data: EIA STEOs','fontsize',11,'units','normalized')

%%
pngname='~/projects/eia/post/steo_global_consumption';
print(pngname,'-dpng')