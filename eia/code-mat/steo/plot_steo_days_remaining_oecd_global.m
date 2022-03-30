cca

dirname_base={'mar22'};
lgnnames={'STEO March 22'};

nd=numel(dirname_base);

for i=1:nd
    dirnames{i}=[dirname_base{i},'_base.xlsx'];
end

prod_color=[0 0.4470 0.7410];
consum_color=[0.8500 0.3250 0.0980];

lgs=[];
    
[cdates,consumption]=load_steo_global_consumption(dirnames{1});
[idates,inventory]=load_steo_oecd_inven(dirnames{1});

days_remaining=inventory./consumption;

p=plot(cdates,days_remaining,'linewidth',3,'color',prod_color);

lgs=[lgs {'March ''22 Days Remaining'}];


lgn=legend(lgs,'fontsize',25);
%lgn.Position=[0.1929 0.7793 0.2625 0.0941];

grid on

ax=gca;
ax.FontSize=24;

yticks=[90:0.5:106];
%ax.YTick=yticks;
ytickformat('%,.1f')
ax=gca;
ax.YAxis(1).Exponent=0;

%ylim([99 104.5])
%yliml=ylim;


ylbl=ylabel('Days Remaining');
%ylbl.Position(1)=-230;

yyaxis right
%ylim(yliml)
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