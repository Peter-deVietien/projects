cca

load_ppp_worldbank

%%

countries={'Canada','Germany','France','EuropeanUnion'};
legendstr={'Canada','Germany','France','European Union'};
nc=numel(countries);

for i=1:nc
    ppp=t.(countries{i});
    
    hold on
    plot(t.Year,ppp,'linewidth',4)
    hold off

end


fig=gcf;
fig.Position=[476 388 865 478];

ax=gca;
ax.FontSize=17;
grid on

ytickformat('%,.0d')
ax.YAxis(1).Exponent=0;

y_lim=[20000 60000];
ylim(y_lim)
yticks=ax.YTick;

ylbl=ylabel('International Dollars [$]');
ylbl.Position=[1.25e+04 4.0000e+04 -1];

yyaxis right

ax=gca;
ax.YTick=yticks;
ax.YAxis(2).Color='k';
ylim(y_lim)
ytickformat('%,.0d')
ax.YAxis(2).Exponent=0;

lgn=legend(legendstr,'fontsize',18);
lgn.Position=[0.1595 0.7249 0.1977 0.1454];

tstr=sprintf('WorldBank PPP GDP Per Capita');
title(tstr,'fontsize',25)

text(datetime(2014,6,1),2100,'@peterdevietien','fontsize',17)

x_lim=[datetime(1997,1,1) datetime()+calmonths(24)];
xlim(x_lim)

%%
text(0.55,-0.1,'Twitter: @peterdevietien   Data: WorldBank','fontsize',17,'units','normalized')
text(0.66,0.12,sprintf('PPP = Purchasing Power Parity: How much purchasing power\n the average citizen has relative to the average citizen of a \ndifferent country, taking into account the differing cost \n of goods, incomes and exchange rates'),'units','normalized','horizontalalignment','center','fontsize',16)

filename='ppp_canada_eu';
print(sprintf('~/projects/capitalism/post/%s',filename),'-dpng')