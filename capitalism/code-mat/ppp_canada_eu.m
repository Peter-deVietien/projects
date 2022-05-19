cca

load_ppp_worldbank

%%
newcolors = [0.83 0.14 0.14
             1.00 0.54 0.00
             0.47 0.25 0.80
             0.25 0.80 0.54];
         
%newcolors = {'#F00','#F80','#FF0','#0B0','#00F','#50F','#A0F'};

colororder(newcolors)

countries={'Germany','France','EuropeanUnion','Canada'};
legendstr={'Germany','France','European Union','Canada'};
nc=numel(countries);

for i=1:nc
    ppp=t.(countries{i});
    
    if strcmp(countries{i},'Canada')
        lw=6;
    else
        lw=1;
    end
    
    hold on
    plot(t.Year,ppp,'linewidth',lw)
    hold off

end


fig=gcf;
scale=2;
fig.Position=[75.8000 342 1200/scale 675/scale];

ax=gca;
ax.FontSize=17;
grid on

ytickformat('%,.0d')
ax.YAxis(1).Exponent=0;

y_lim=[20000 60000];
ylim(y_lim)
yticks=ax.YTick;

ylbl=ylabel('International Dollars [$]');
%ylbl.Position=[1.25e+04 4.0000e+04 -1];

yyaxis right

ax=gca;
ax.YTick=yticks;
ax.YAxis(2).Color='k';
ylim(y_lim)
ytickformat('%,.0d')
ax.YAxis(2).Exponent=0;

lgn=legend(legendstr,'fontsize',18);
lgn.Position=[0.1492 0.5848 0.2850 0.2715];

tstr=sprintf('WorldBank PPP GDP Per Capita');
title(tstr,'fontsize',25)

text(datetime(2014,6,1),2100,'@peterdevietien','fontsize',17)

x_lim=[datetime(1997,1,1) datetime()-calmonths(12)];
xlim(x_lim)

%%
t1=text(-0.154,-0.108,'Twitter: @peterdevietien   Data: WorldBank','fontsize',11,'units','normalized');
t2=text(0.66,0.12,sprintf('PPP = Purchasing Power Parity = Living Standard\nThe amount of goods and services of the same quality \nthat can be purchased by the average person, taking into\n account local wages, exchange rates, and local costs'),'units','normalized','horizontalalignment','center','fontsize',12);

filename='ppp_canada_eu_post';
print(sprintf('~/projects/capitalism/post/%s',filename),'-dpng')