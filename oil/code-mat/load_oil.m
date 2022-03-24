cca
reset(0)
set(0,'defaultlinelinewidth',5)

d=readtable('inventories.dat','Format','%D%s%f%f%f');
d=flipud(d);

inv=cumsum(d.Actual)+403.7;
lgs=[];
h=plot(d.Release_Date,inv,'k');
lgs=[lgs {sprintf('Inventories MB')}];

%%
set(0,'defaultlinelinewidth',2)

addpath('/Users/peter/Documents/Finance/code/moving_average')
ticker='CL=F';
yyaxis right
ax=gca;
overlay_price

%%
xlim([datetime(2018,01,01) datetime(2021,01,01)])
ylim([20 80])
grid on

ax.FontSize=23;
ylabel('Crude Price $')
yyaxis left
ylabel(sprintf('US Commercial Oil Inventory \n(Millions Barrels)'))

legend(h,lgs,'location','west')

fig=gcf;
fig.Position=[200 204 895 496];

title('2018-2021 US Crude Oil Inventory and Price')
print('crude_inventories_price','-dpng')